import 'package:app/components/atividade-escolha-codigo.dart';
import 'package:app/components/atividade-escolha-comandos.dart';
import 'package:app/model/atividade-codigo.dart';
import 'package:app/shared/functions/convertToFraction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../shared/values/colors.dart';

final porcentagemAtividadeConcluida = StateProvider<double>((ref) => 0.0);
const int totalAtividades = 2;


class Pratica extends ConsumerWidget {
  const Pratica({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int activityType = 1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: fifthColor,
        title: LinearPercentIndicator(
          lineHeight: 20,
          percent: ref.watch(porcentagemAtividadeConcluida),
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
              Navigator.pop(context);
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
                      const AtividadeEscolhaComandos()
                    else if (activityType == 1)
                      AtividadeEscolhaCodigo()
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(porcentagemAtividadeConcluida.notifier).state =
                      getPercentageOfOneFromTotal(totalAtividades) +
                          ref.watch(porcentagemAtividadeConcluida);
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
}
