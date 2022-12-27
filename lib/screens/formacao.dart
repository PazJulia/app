import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

import 'explicacao.dart';

class FormacaoCards extends StatelessWidget {
  const FormacaoCards({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        backgroundColor: primaryColor,
        shadowColor: const Color.fromARGB(10, 0, 0, 0));

    return ListView(
      padding: const EdgeInsets.only(top: 0, right: 10, bottom: 10, left: 10),
      reverse: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            shadowColor: const Color.fromARGB(10, 0, 0, 0),
            color: const Color.fromARGB(255, 195, 219, 255),
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: Column(children: [
              SizedBox(
                width: double.infinity,
                child:
                    Column(verticalDirection: VerticalDirection.up, children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: style,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, bottom: 13),
                        child: Text('Teste 1',
                            style: TextStyle(color: secondaryColor)),
                      ),onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Explicacao() ));
                    },
                    ),
                  ),
                ]),
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
