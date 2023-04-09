import 'package:app/components/alert.dart';
import 'package:app/components/atividade-escolha-codigo.dart';
import 'package:app/components/atividade-alternativa.dart';
import 'package:app/core/domain/licao/alternativa.dart';
import 'package:app/core/domain/licao/questao.dart';
import 'package:app/core/domain/model/tipo-atividade.dart';
import 'package:app/shared/functions/convertToFraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter/services.dart';

import '../core/domain/licao/sequencia.dart';
import '../shared/values/colors.dart';

final porcentagem = StateProvider.autoDispose<double>((ref) => 0.0);

final isAtividadeEmptyNotifier = StateProvider.autoDispose((ref) => true);
final indexNotifier = StateProvider.autoDispose((ref) => 0);
final isLoadingNotifier = StateProvider.autoDispose((ref) => false);
final isCorrectNotifier = StateProvider.autoDispose((ref) => false);
final isAnswerVerifiedNotifier = StateProvider.autoDispose((ref) => false);

class Pratica extends ConsumerWidget {
  const Pratica({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questoes =
        ModalRoute.of(context)?.settings.arguments as List<Questao>?;
    int? total = questoes?.length;

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
            formatDoubleToFractionToText(total!, ref.watch(porcentagem)),
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
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 5, bottom: 20, left: 5),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          Text(
                            questoes![index].textoInicial,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            questoes[index].pergunta,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    buildAtividadeWidget(questoes, index, ref),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                buildBottomWidget(isAtividadeEmpty, ref, index, total, questoes),
                buildAnswerWidget(ref, index, total),
              ],
            )
            //buildBottomWidget(isAtividadeEmpty, ref, index, total, questoes),
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
          questoes?[index].sequencias, ref);
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
                verifyAnswer(ref, questoes, index);
                //initiateNextActivity(ref, atividadeIndex, total);
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

  Widget buildAnswerWidget(WidgetRef ref, int index, int total) {
    var isCorrect = ref.watch(isCorrectNotifier);
    var isAnswerVerified = ref.watch(isAnswerVerifiedNotifier);
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
                    onPressed: () => {initiateNextActivity(ref, index, total)},
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
      ref.read(atividadeCodigoProvider.notifier).setActivity(list!, true);
    });

    return AtividadeEscolhaCodigo(list!);
  }

  initiateAtividadeSequenciaWidget(List<Alternativa>? list, WidgetRef ref) {
    Future(() {
      ref.read(alternativa.notifier).setActivity(list!, false);
    });

    return const AtividadeAlternativa();
  }

  verifyAnswer(WidgetRef ref, questoes, int index) async {
    setLoading(ref, true);
    if (questoes[index].tipo == TipoAtividade.perguntaResposta.name) {
      var selected = ref
          .watch(alternativa)
          .firstWhere((element) => element.estado == true);
      if (selected.itemAtividade.verdadeira) {
        ref.read(isAnswerVerifiedNotifier.notifier).state = true;
        ref.read(isCorrectNotifier.notifier).state = true;
      } else {
        ref.read(isAnswerVerifiedNotifier.notifier).state = true;
        ref.read(isCorrectNotifier.notifier).state = false;
      }
    } else if (questoes[index].tipo == TipoAtividade.programacao.name) {
      //
    }
    await Future.delayed(const Duration(milliseconds: 500));
    //initiateNextActivity(ref, index, questoes.length);
    setLoading(ref, false);
  }

  setLoading(WidgetRef ref, bool isLoading) {
    ref.read(isLoadingNotifier.notifier).state = isLoading;
  }

  initiateNextActivity(WidgetRef ref, int index, int total) {
    ref.read(porcentagem.notifier).state =
        getPercentageOfOneFromTotal(total) + ref.watch(porcentagem);
    ref.read(indexNotifier.notifier).state = index + 1;
    ref.read(isAtividadeEmptyNotifier.notifier).state = true;
    setLoading(ref, false);
  }
}
