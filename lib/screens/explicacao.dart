import 'package:app/components/explicacao-slides.dart';
import 'package:app/core/domain/licao/licao-controller.dart';
import 'package:app/core/domain/licao/licao.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/stars-rating.dart';

class Explicacao extends StatelessWidget {
  const Explicacao(int this.licaoId, String this.licaoNome, {super.key});

  final int licaoId;
  final String licaoNome;

  @override
  Widget build(BuildContext context) {
    LicaoController licaoController = LicaoController();

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: secondaryColor),
          toolbarHeight: 80,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: secondaryColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                licaoNome,
                style: TextStyle(color: primaryColor),
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
              color: Colors.white,
              icon: const Icon(
                Icons.cancel,
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: licaoController.listLicao(licaoId),
          //fetch data using LicaoController
          builder: (BuildContext context, AsyncSnapshot<Licao> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Ocorreu um erro'),
              );
            }
            final licao = snapshot.data;
            return ExplicacaoSlides(
                licao!); //render UI using data returned from LicaoController
          },
        ),
    );
  }
}
