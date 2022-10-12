import 'package:flutter/material.dart';

class FormacaoCards extends StatelessWidget {
  const FormacaoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
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
              elevation: 2,
              child: const SizedBox(
                width: double.infinity,
                height: 100,
                child: Center(child: Text('TESTE CARD DE ATIVIDADES')),
              ),
            ),
          ],
        ));
  }
}
