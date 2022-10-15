import 'package:flutter/material.dart';

class FormacaoCards extends StatelessWidget {
  const FormacaoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            shadowColor: const Color.fromARGB(10, 0, 0, 0),
            color: const Color.fromARGB(255, 195, 219, 255),
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 25,
                          height: 50,
                          width: 100,
                          child: Container(
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Teste de descrição de módulooooooooooooooooooooooooooooooooooooo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
