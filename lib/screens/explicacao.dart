import 'package:app/components/explicacao-slides.dart';
import 'package:app/core/domain/licao/licao-controller.dart';
import 'package:app/core/domain/licao/licao.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/stars-rating.dart';

class Explicacao extends StatelessWidget {
  const Explicacao(int this.licaoId, String this.licaoNome, String this.cor, {super.key});

  final int licaoId;
  final String licaoNome;
  final String cor;

  @override
  Widget build(BuildContext context) {
    LicaoController licaoController = LicaoController();

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: primaryColor),
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              licaoNome,
              style: TextStyle(color: secondaryColor),
            ),
            const StarsRating(),
          ],
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(
              Icons.cancel,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: licaoController.listLicao(licaoId),
        builder: (BuildContext context, AsyncSnapshot<Licao> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }
          else {
            return ExplicacaoSlides(snapshot.data!, cor);
          }
        },
      ),
    );
  }
}
