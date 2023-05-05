import 'package:app/components/stars-rating.dart';
import 'package:app/core/domain/extrato-licao/extrato-licao-controller.dart';
import 'package:app/core/domain/extrato-licao/extrato-licao.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

class ResultadoLicao extends StatelessWidget {
  const ResultadoLicao({super.key});

  @override
  Widget build(BuildContext context) {
    final extrato = ModalRoute.of(context)?.settings.arguments as ExtratoLicao;
    ExtratoLicaoController extratoLicaoController = ExtratoLicaoController();

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () => {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false)
        },
        child: Icon(Icons.home, color: primaryColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: FutureBuilder(
        future: extratoLicaoController.postExtratoLicao(extrato),
        builder: (BuildContext context, AsyncSnapshot<ExtratoLicao> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[ StarsRating(estrela: snapshot.data?.estrela)],
                    ),
                    Text(
                        'Você conquistou: ${snapshot.data?.pontuacaoTotal} XP!', style: const TextStyle(fontSize: 20),)
                  ]),
            );
          }
        },
      ),
    );
  }
}
