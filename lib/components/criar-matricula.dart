import 'package:app/components/linguagens-disponiveis.dart';
import 'package:flutter/material.dart';

import '../core/domain/linguagem/linguagem-controller.dart';

class CriarMatricula extends StatelessWidget {
  const CriarMatricula({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinguagemController linguagemController = LinguagemController();

    return FutureBuilder(
        future: linguagemController.listLinguagens(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return LinguagensDisponiveis(
              linguagens: snapshot.data!,
              isNewLinguagem: true,
            );
          }
        });
  }
}
