import 'package:app/core/domain/matricula/matricula-controller.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

import '../core/domain/ranking/ranking.dart';
import '../shared/functions/get-cor-ranking.dart';

class RankingUsuario extends StatelessWidget {
  const RankingUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MatriculaController matriculaController = MatriculaController();

    return FutureBuilder<List<Ranking>>(
        future: matriculaController.getRankingUsuario(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Você ainda não possui pontuação semanal ou sua pontuação é insuficiente para aparecer no ranking.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ranking(snapshot.data!);
            }
          }
        });
  }

  Widget ranking(List<Ranking> ranking) {
    Color corRanking = getCorRanking(ranking[0].ranking);

    return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            shadowColor: const Color.fromARGB(10, 0, 0, 0),
            color: primaryColor,
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: Column(children: [
              Container(
                  alignment: Alignment.center,
                  color: secondaryColor,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, top: 20, right: 25, bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.grid_3x3_outlined,
                              color: corRanking,
                              size: 30,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'DIVISÃO ${ranking[0].ranking}',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 16),
                            ),
                            const SizedBox(width: 20),
                            Icon(
                              Icons.grid_3x3_outlined,
                              color: corRanking,
                              size: 30,
                            )
                          ]))),
              Expanded(
                  child: ListView.builder(
                      itemCount: ranking.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.all(20),
                            color: ranking[index].usuarioPrincipal
                                ? thirdColor
                                : Colors.transparent,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Text(
                                      '${index + 1}°',
                                      style: getEstiloBold(
                                          ranking[index].usuarioPrincipal),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      ranking[index].nomeUsuario,
                                      style: TextStyle(
                                        color: ranking[index].usuarioPrincipal
                                            ? secondaryColor
                                            : ninthColor,
                                      ),
                                    )
                                  ]),
                                  Text('${ranking[index].pontuacaoSemanal} XP',
                                      style: getEstiloBold(
                                          ranking[index].usuarioPrincipal)),
                                ]));
                      }))
            ])));
  }

  TextStyle getEstiloBold(bool isUsuarioPrincipal) {
    return TextStyle(
        color: isUsuarioPrincipal ? secondaryColor : ninthColor,
        fontSize: 16,
        fontWeight: FontWeight.bold);
  }
}
