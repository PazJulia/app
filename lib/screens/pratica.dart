import 'package:app/components/atividade-escolha-codigo.dart';
import 'package:app/components/atividade-escolha-comandos.dart';
import 'package:app/shared/functions/convertToFraction.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../shared/values/colors.dart';

class Pratica extends StatefulWidget {
  const Pratica({super.key});

  @override
  _PraticaState createState() => _PraticaState();
}

class _PraticaState extends State<Pratica> {
  double porcentagemAtividadeConcluida = 0.0;
  int totalAtividades = 2;

  @override
  Widget build(BuildContext context) {
    int activityType = 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: fifthColor,
        title: LinearPercentIndicator(
          lineHeight: 20,
          percent: porcentagemAtividadeConcluida,
          center: Text(
            formatDoubleToFractionToText(totalAtividades, porcentagemAtividadeConcluida),
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
                      const AtividadeEscolhaCodigo()
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null,
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
