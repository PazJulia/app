import 'package:app/components/criar-matricula.dart';
import 'package:app/core/domain/linguagem/linguagem-controller.dart';
import 'package:app/core/domain/linguagem/linguagem.dart';
import 'package:app/shared/functions/guardar-linguagem-e-redirecionar.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

import '../components/linguagens-disponiveis.dart';

class EscolhaLinguagem extends StatelessWidget {
  const EscolhaLinguagem({super.key});

  @override
  Widget build(BuildContext context) {
    LinguagemController linguagemController = LinguagemController();

    return Scaffold(
        backgroundColor: fifthColor,
        body: Center(
            child: FutureBuilder<List<Linguagem>>(
                future: linguagemController.listLinguagensByUsuario(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data!.length <= 1) {
                      if (snapshot.data!.isEmpty) {
                        return const CriarMatricula();
                      } else {
                        guardarLinguagemRedirecionar(
                            snapshot.data![0].id, context);
                      }
                      return const CircularProgressIndicator();
                    } else {
                      return LinguagensDisponiveis(
                        linguagens: snapshot.data!,
                        isNewLinguagem: false,
                      );
                    }
                  }
                })));
  }
}
