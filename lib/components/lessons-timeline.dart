import 'package:app/components/stars-rating.dart';
import 'package:app/core/domain/modulo/modulos.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../screens/explicacao.dart';
import '../shared/values/colors.dart';

class LessonsTimeline extends StatelessWidget {
  const LessonsTimeline({Key? key, required this.licoes}) : super(key: key);

  final List<Licoes> licoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        const Divider(
          color: Colors.transparent,
          height: 20,
        ),
        for (final licao in licoes)
          Row(
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    StarsRating(),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: TimelineNode(
                  indicatorPosition: 1,
                  startConnector: SolidLineConnector(
                    color: secondaryColor,
                  ),
                  indicator: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Explicacao(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: secondaryColor,
                    ),
                    child: Icon(Icons.not_started_rounded,
                        color: primaryColor, size: 50),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
