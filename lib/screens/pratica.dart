import 'package:app/components/atividade-escolha-codigo.dart';
import 'package:app/components/atividade-alternativa.dart';
import 'package:app/core/domain/licao/alternativa.dart';
import 'package:app/core/domain/licao/questao.dart';
import 'package:app/shared/functions/convertToFraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter/services.dart';

import '../core/domain/licao/comando.dart';
import '../shared/values/colors.dart';

final porcentagemAtividadeConcluida =
    StateProvider.autoDispose<double>((ref) => 0.0);

final isAtividadeEmptyNotifier = StateProvider.autoDispose((ref) => true);
final activityIndexNotifier = StateProvider.autoDispose((ref) => 0);

class Pratica extends ConsumerWidget {
  const Pratica({super.key});

  static const int totalAtividades = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questoes =
        ModalRoute.of(context)?.settings.arguments as List<Questao>?;

    bool isAtividadeEmpty = ref.watch(isAtividadeEmptyNotifier);
    int atividadeIndex = ref.watch(activityIndexNotifier);
    double percentActivity = ref.watch(porcentagemAtividadeConcluida);

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
          percent: percentActivity,
          center: Text(
            formatDoubleToFractionToText(
                totalAtividades, ref.watch(porcentagemAtividadeConcluida)),
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
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            questoes![atividadeIndex].textoInicial,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            questoes[atividadeIndex].pergunta,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    if (questoes[atividadeIndex].tipo == 'PerguntaResposta')
                      initiateAtividadeEscolhaComandosWidget(questoes[atividadeIndex].alternativas, ref)
                    else if (questoes[atividadeIndex].tipo == 'Programacao')
                      initiateAtividadeEscolhaCodigoWidget(questoes[atividadeIndex].comandos, ref)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isAtividadeEmpty == true
                    ? null
                    : () {
                        initiateNextActivity(ref, atividadeIndex);
                      },
                style: ElevatedButton.styleFrom(
                  shape: const BeveledRectangleBorder(),
                  backgroundColor: thirdColor,
                  shadowColor: Colors.transparent,
                  disabledBackgroundColor: primaryColor,
                ),
                child: const Text(
                  'VERIFICAR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  initiateAtividadeEscolhaCodigoWidget(List<Comando>? list, WidgetRef ref) {
    Future(() {
      ref.read(atividadeCodigoProvider.notifier).setActivity(list!, true);
    });

    return AtividadeEscolhaCodigo(list!);
  }

  initiateAtividadeEscolhaComandosWidget(List<Alternativa>? list, WidgetRef ref) {
    Future(() {
      ref.read(atividadeAlternativa.notifier).setActivity(list!, false);
    });

    return const AtividadeAlternativa();
  }

  initiateNextActivity(WidgetRef ref, int atividadeIndex) {
    ref.read(porcentagemAtividadeConcluida.notifier).state =
        getPercentageOfOneFromTotal(totalAtividades) +
            ref.watch(porcentagemAtividadeConcluida);
    ref.read(activityIndexNotifier.notifier).state = atividadeIndex + 1;
    if (ref.watch(isAtividadeEmptyNotifier) == false) {
      ref.read(isAtividadeEmptyNotifier.notifier).state = true;
    }
  }
}
