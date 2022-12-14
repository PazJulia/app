import 'package:flutter/material.dart';

import '../components/lessons-timeline.dart';

class FormacaoCards extends StatelessWidget {
  const FormacaoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 0, right: 10, bottom: 10, left: 10),
      reverse: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            shadowColor: const Color.fromARGB(10, 0, 0, 0),
            color: const Color.fromARGB(255, 195, 219, 255),
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: Column(children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: LessonsTimeline(),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 15, right: 20, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Título Módulo',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Teste de descrição de módulooooooooooooooooooooooooooooooooooooo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
