import 'package:app/components/stars-rating.dart';
import 'package:app/core/domain/extrato-licao/extrato-licao-controller.dart';
import 'package:app/core/domain/extrato-licao/extrato-licao.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

class ResultadoLicao extends StatefulWidget {
  const ResultadoLicao({Key? key}) : super(key: key);

  @override
  ResultadoLicaoState createState() => ResultadoLicaoState();
}

class ResultadoLicaoState extends State<ResultadoLicao> {
  final extratoLicaoController = ExtratoLicaoController();
  late Future<ExtratoLicao>? _extratoLicaoFuture;
  bool _isPostExtratoLicaoCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extrato = ModalRoute.of(context)?.settings.arguments as ExtratoLicao;

    if (!_isPostExtratoLicaoCalled) {
      _extratoLicaoFuture = extratoLicaoController.postExtratoLicao(extrato);
      _isPostExtratoLicaoCalled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(height: 50.0),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          child: Icon(Icons.home, color: primaryColor),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: FutureBuilder(
            future: _extratoLicaoFuture,
            builder:
                (BuildContext context, AsyncSnapshot<ExtratoLicao> snapshot) {
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
                if (snapshot.data?.pontuacaoTotal == 0) {
                  return pontuacaoInsuficiente();
                }
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: fourthColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: StarsRating(
                                estrela: snapshot.data?.estrela, isDark: false),
                          )
                        ],
                      ),
                      Container(height: 10),
                      Text(
                        'Você conquistou: ${snapshot.data?.pontuacaoTotal} XP!',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      pontuacaoBonus(snapshot.data?.pontuacaoBonus),
                    ]));
              }
            }));
  }

  Widget pontuacaoBonus(int? pontuacaoBonus) {
    if (pontuacaoBonus != null && pontuacaoBonus > 0) {
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(height: 10),
        Icon(Icons.add, color: fourthColor, size: 40),
        Container(height: 10),
        Text(
          '${pontuacaoBonus.toString()} XP de bônus!',
          style: const TextStyle(fontSize: 20),
        )
      ]);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget pontuacaoInsuficiente() {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.close, size: 40, color: tenthColor),
      const Text('Oops...',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Container(height: 10),
      const Text('Dessa vez você não conquistou XP',
          style: TextStyle(fontSize: 20)),
      Container(height: 10),
      const Text('Tente novamente!', style: TextStyle(fontSize: 20)),
    ]));
  }
}
