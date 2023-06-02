import 'package:app/core/domain/linguagem/linguagem.dart';
import 'package:app/core/domain/matricula/matricula-controller.dart';
import 'package:app/shared/functions/guardar-linguagem-e-redirecionar.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

class LinguagensDisponiveis extends StatelessWidget {
  const LinguagensDisponiveis(
      {Key? key, required this.linguagens, required this.isNewLinguagem})
      : super(key: key);

  final List<Linguagem> linguagens;
  final bool isNewLinguagem;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Center(
                      child: Text('Para continuar, escolha uma linguagem',
                          style: TextStyle(fontSize: 16)))),
              GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 10 / 4,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(linguagens.length, (index) {
                    final item = linguagens[index];
                    return TextButton(
                        onPressed: () {
                          isNewLinguagem
                              ? criarMatricula(item.id, context)
                              : guardarLinguagemRedirecionar(item.id, context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                                child: Text(
                              item.nome,
                              style: TextStyle(color: secondaryColor),
                            ))));
                  }))
            ]));
  }

  criarMatricula(int idLinguagem, context) {
    MatriculaController matriculaController = MatriculaController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 100,
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    matriculaController.createMatricula(idLinguagem).then((result) {
      // Close the dialog
      Navigator.of(context).pop();

      if (result is Exception) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text("An error occurred: ${result.toString()}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        guardarLinguagemRedirecionar(idLinguagem, context);
      }
    });
  }
}
