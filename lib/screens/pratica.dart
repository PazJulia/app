import 'package:app/components/atividade-escolha-codigo.dart';
import 'package:app/components/atividade-escolha-comandos.dart';
import 'package:app/shared/functions/convertToFraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../shared/values/colors.dart';

final porcentagemAtividadeConcluida =
    StateProvider.autoDispose<double>((ref) => 0.0);

final isAtividadeEmptyNotifier = StateProvider.autoDispose((ref) => true);
final activityTypeNotifier = StateProvider.autoDispose((ref) => 0);

class Pratica extends ConsumerWidget {
  const Pratica({super.key});

  static const int totalAtividades = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool activityEmpty = ref.watch(isAtividadeEmptyNotifier);
    int activityType = ref.watch(activityTypeNotifier);
    double percentActivity = ref.watch(porcentagemAtividadeConcluida);

    return Scaffold(
      appBar: AppBar(
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
              Navigator.popUntil(context, ModalRoute.withName('/'));
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Texto de descrição da atividade\n\nLorem ipsum lorem lorem:\nexemplo exemplo',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (activityType == 0)
                      initiateAtividadeEscolhaComandosWidget([
                        'a = 3',
                        'a = \'python\'',
                        'print(python)',
                        'a = python'
                      ], ref)
                    else if (activityType == 1)
                      initiateAtividadeEscolhaCodigoWidget(
                          ['"', '"', ' = ', '(', ')', 'string python', 'x'],
                          ref)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: activityEmpty == true
                    ? null
                    : () {
                        initiateNextActivity(ref, activityType + 1);
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

  initiateAtividadeEscolhaCodigoWidget(List<String> list, WidgetRef ref) {
    Future(() {
      ref.read(atividadeCodigoProvider.notifier).setCodigos(list, true);
    });

    return AtividadeEscolhaCodigo(list);
  }

  initiateAtividadeEscolhaComandosWidget(List<String> list, WidgetRef ref) {
    Future(() {
      ref.read(atividadeEscolhaComandos.notifier).setCodigos(list, false);
    });

    return const AtividadeEscolhaComandos();
  }

  initiateNextActivity(WidgetRef ref, int activityType) {
    ref.read(porcentagemAtividadeConcluida.notifier).state =
        getPercentageOfOneFromTotal(totalAtividades) +
            ref.watch(porcentagemAtividadeConcluida);
    ref.read(activityTypeNotifier.notifier).state = activityType;
    if (ref.watch(isAtividadeEmptyNotifier) == false) {
      ref.read(isAtividadeEmptyNotifier.notifier).state = true;
    }
  }
}
