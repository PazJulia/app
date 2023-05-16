import 'package:collection/collection.dart';
import 'package:app/components/stars-rating.dart';
import 'package:app/core/domain/modulo/modulos.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../screens/explicacao.dart';
import '../shared/values/colors.dart';

class LessonsTimeline extends StatelessWidget {
  const LessonsTimeline({Key? key, required this.licoes, required this.cor}) : super(key: key);

  final List<Licoes> licoes;
  final String cor;

  @override
  Widget build(BuildContext context) {
    final rows = licoes
        .mapIndexed((index, licao) => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        licao.nome,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: secondaryColor,
                        ),
                      ),
                      StarsRating(estrela: licao.estrela, isDark: true),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: TimelineNode(
                    indicatorPosition: 1,
                    startConnector: index + 1 == licoes.length ? null : SolidLineConnector(
                      color: secondaryColor,
                    ),
                    indicator: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Explicacao(licao.id, licao.nome, cor),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: primaryColor,
                        fixedSize: const Size(50, 50),
                        shadowColor: Colors.transparent,
                      ),
                      child: Icon(Icons.play_arrow_rounded,
                          color: secondaryColor, size: 30),
                    ),
                  ),
                ),
              ],
            ))
        .toList();

    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        const Divider(
          color: Colors.transparent,
          height: 20,
        ),
        ...rows,
      ],
    );
  }
}
