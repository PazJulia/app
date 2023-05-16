import 'package:app/core/domain/modulo/modulos-controller.dart';
import 'package:app/core/domain/modulo/modulos.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

import '../components/lessons-timeline.dart';
import '../shared/functions/convert-color.dart';

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
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
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
                                child: LessonsTimeline(licoes: item.licoes, cor: item.cor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.bottomLeft,
                          color: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 20, right: 25, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.nome,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16),
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 10,
                                ),
                                Text(
                                  item.descricao,
                                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.w300, fontSize: 16),
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
