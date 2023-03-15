import 'package:app/core/domain/modulo/modulos-controller.dart';
import 'package:app/core/domain/modulo/modulos.dart';
import 'package:flutter/material.dart';

import '../components/lessons-timeline.dart';
import '../shared/functions/convertColor.dart';

class FormacaoCards extends StatelessWidget {
  const FormacaoCards({super.key});

  @override
  Widget build(BuildContext context) {
    ModulosController modulosController = ModulosController();

    return
      FutureBuilder<List<Modulos>>(
        future: modulosController.modulosList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator while data is being fetched
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Return an error message if there is an error
            return Text('Error: ${snapshot.error}');
          } else {
            // Return your ListView with the data
            return ListView.builder(
              padding: const EdgeInsets.only(
                  top: 0, right: 10, bottom: 10, left: 10),
              reverse: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: const Color.fromARGB(10, 0, 0, 0),
                    color: convertToColor(item.cor),
                    clipBehavior: Clip.hardEdge,
                    elevation: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            verticalDirection: VerticalDirection.up,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: LessonsTimeline(licoes: item.licoes),
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
                              children: [
                                Text(
                                  item.nome,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  item.descricao,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      );
  }
}
