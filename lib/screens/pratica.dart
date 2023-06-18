import 'package:app/core/domain/extrato-licao/extrato-licao.dart';
import 'package:app/core/domain/licao/licao.dart';
import 'package:collection/collection.dart';
import 'package:app/components/atividade-escolha-codigo.dart';
import 'package:app/components/atividade-alternativa.dart';
import 'package:app/core/domain/licao/alternativa.dart';
import 'package:app/core/domain/licao/questao.dart';
import 'package:app/core/domain/model/tipo-atividade.dart';
import 'package:app/shared/functions/convert-to-fraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter/services.dart';

import '../core/domain/licao/sequencia.dart';
import '../shared/functions/get-current-date-time-utc.dart';
import '../shared/values/colors.dart';

final porcentagem = StateProvider.autoDispose<double>((ref) => 0.0);

final isAtividadeEmptyNotifier = StateProvider.autoDispose((ref) => true);
final indexNotifier = StateProvider.autoDispose((ref) => 0);
final isLoadingNotifier = StateProvider.autoDispose((ref) => false);
final isCorrectNotifier = StateProvider.autoDispose((ref) => false);
final isAnswerVerifiedNotifier = StateProvider.autoDispose((ref) => false);
final scoreNotifier = StateProvider.autoDispose((ref) => 0);

class Pratica extends ConsumerWidget {
  const Pratica({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final licao = ModalRoute.of(context)?.settings.arguments as Licao;
    final questoes = licao.questoes;

    int? total = questoes.length;

    bool isAtividadeEmpty = ref.watch(isAtividadeEmptyNotifier);
    int index = ref.watch(indexNotifier);
    double percent = ref.watch(porcentagem);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: fifthColor),
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: fifthColor,
        title: LinearPercentIndicator(
          lineHeight: 20,
          percent: percent,
          animation: true,
          animationDuration: 300,
          center: Text(
            formatDoubleToFractionToText(total, ref.watch(porcentagem)),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          barRadius: const Radius.circular(16),
          progressColor: fourthColor,
          backgroundColor: sixthColor,
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            color: secondaryColor,
            icon: const Icon(
              Icons.cancel,
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: fifthColor,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                questoes[index].textoInicial != '' ? Text(
                                  questoes[index].textoInicial,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18),
                                ) : Container(),
                                const SizedBox(
                                  height: 10,
                                ),
                                questoes[index].pergunta != '' ? Text(
                                  questoes[index].pergunta,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) : Container(),
                              ],
                            ),
                          ),
                        ),
                        buildAtividadeWidget(questoes, index, ref),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                buildBottomWidget(
                    isAtividadeEmpty, ref, index, total, questoes),
                buildAnswerWidget(ref, context, index, total, licao),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAtividadeWidget(
      List<Questao>? questoes, int index, WidgetRef ref) {
    if (questoes?[index].tipo == TipoAtividade.perguntaResposta.name) {
      return initiateAtividadeSequenciaWidget(
          questoes?[index].alternativas, ref);
    } else if (questoes?[index].tipo == TipoAtividade.programacao.name) {
      return initiateAtividadeEscolhaCodigoWidget(
          questoes?[index].shuffledSequencias, ref);
    }
    return const SizedBox();
  }

  Widget buildBottomWidget(
    bool isAtividadeEmpty,
    WidgetRef ref,
    int index,
    int total,
    List<Questao> questoes,
  ) {
    var isLoading = ref.watch(isLoadingNotifier);
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isAtividadeEmpty == true
            ? null
            : () {
                verifyAnswer(ref, questoes, index, total);
              },
        style: ElevatedButton.styleFrom(
          shape: const BeveledRectangleBorder(),
          backgroundColor: thirdColor,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: primaryColor,
        ),
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              )
            : const Text(
                'VERIFICAR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget buildAnswerWidget(
      WidgetRef ref, context, int index, int total, licao) {
    var isCorrect = ref.watch(isCorrectNotifier);
    var isAnswerVerified = ref.watch(isAnswerVerifiedNotifier);
    ExtratoLicao extrato = ExtratoLicao(
        idLicao: licao.id,
        dataHora: getCurrentDateTimeUtc(),
        pontuacaoTotal: ref.watch(scoreNotifier),
        pontuacaoBonus: 0);

    return Visibility(
      visible: isAnswerVerified,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Container(
          color: isCorrect ? Colors.green[100] : Colors.red[100],
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isCorrect ? 'Resposta correta' : 'Resposta incorreta',
                  style: TextStyle(
                      color: isCorrect ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () => {
                          if (index + 1 < total)
                            {
                              initiateNextActivity(ref, index),
                              ref
                                  .read(isAnswerVerifiedNotifier.notifier)
                                  .state = false
                            }
                          else
                            {
                              Navigator.pushNamed(context, '/resultado-licao',
                                  arguments: extrato),
                            }
                        },
                    icon: const Icon(Icons.arrow_forward_rounded))
              ],
            ),
          ),
        ),
      ),
    );
  }

  initiateAtividadeEscolhaCodigoWidget(List<Sequencia>? list, WidgetRef ref) {
    Future(() {
      if (!ref.watch(isAnswerVerifiedNotifier)) {
        ref.read(atividadeCodigoProvider.notifier).setActivity(list!, true);
      }
    });

    return AtividadeEscolhaCodigo(list!);
  }

  initiateAtividadeSequenciaWidget(List<Alternativa>? list, WidgetRef ref) {
    Future(() {
      if (!ref.watch(isAnswerVerifiedNotifier)) {
        ref.read(alternativa.notifier).setActivity(list!, false);
      }
    });

    return const AtividadeAlternativa();
  }

  verifyAnswer(
      WidgetRef ref, List<Questao> questoes, int index, int total) async {
    setLoading(ref, true);
    if (questoes[index].tipo == TipoAtividade.perguntaResposta.name) {
      verifyAlternativa(ref, questoes, index);
    } else if (questoes[index].tipo == TipoAtividade.programacao.name) {
      verifySequencia(ref, questoes, index);
    }
    ref.read(porcentagem.notifier).state =
        getPercentageOfOneFromTotal(total) + ref.watch(porcentagem);
    await Future.delayed(const Duration(milliseconds: 500));
    setLoading(ref, false);
  }

  verifyAlternativa(WidgetRef ref, List<Questao> questoes, int index) {
    final alternativas = ref.watch(alternativa);
    final selected =
        alternativas.firstWhere((element) => element.estado == true);
    setAnswerStates(ref, selected.itemAtividade.verdadeira);
  }

  verifySequencia(WidgetRef ref, questoes, int index) {
    final sequencias = ref.watch(respostaCodigo);
    final questaoMap = questoes[index].sequencias.map((e) => e.nome).toList();
    Function deepEq = const DeepCollectionEquality().equals;
    setAnswerStates(ref, deepEq(sequencias, questaoMap));
  }

  setAnswerStates(WidgetRef ref, bool isCorrect) {
    ref.read(isAnswerVerifiedNotifier.notifier).state = true;
    if (isCorrect) {
      ref.read(isCorrectNotifier.notifier).state = true;
      incrementScore(ref);
    } else {
      ref.read(isCorrectNotifier.notifier).state = false;
    }
  }

  incrementScore(WidgetRef ref) {
    ref.read(scoreNotifier.notifier).state = ref.watch(scoreNotifier) + 1;
  }

  setLoading(WidgetRef ref, bool isLoading) {
    ref.read(isLoadingNotifier.notifier).state = isLoading;
  }

  initiateNextActivity(WidgetRef ref, int index) {
    ref.read(indexNotifier.notifier).state = index + 1;
    ref.read(isAtividadeEmptyNotifier.notifier).state = true;
  }
}
