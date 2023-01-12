import 'package:app/components/stars-rating.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../screens/explicacao.dart';
import '../shared/values/colors.dart';

class LessonsTimeline extends StatelessWidget {
  const LessonsTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(verticalDirection: VerticalDirection.up, children: [
      const Divider(
        color: Colors.transparent,
        height: 20,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Título da Lição',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                StarsRating()
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
                          builder: (context) => const Explicacao()));
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: secondaryColor, // <-- Button color
                ),
                child: Icon(Icons.not_started_rounded,
                    color: primaryColor, size: 50),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
