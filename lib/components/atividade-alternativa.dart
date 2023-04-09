import 'package:app/core/domain/licao/alternativa.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/core/domain/model/atividade.dart';
import '../screens/pratica.dart';
import '../state-notifier/atividade-notifier.dart';

final alternativa =
    StateNotifierProvider.autoDispose<AtividadeNotifier, List<Atividade>>(
        (ref) => AtividadeNotifier());

class AtividadeAlternativa extends ConsumerWidget {
  const AtividadeAlternativa({Key? key}) : super(key: key);

  bool hasValidAlternativaAtIndex(List<Atividade> alternativas, int index) {
    return index < alternativas.length &&
        alternativas[index].itemAtividade is Alternativa;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alternativas = ref.watch(alternativa);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 30, right: 20, bottom: 5, left: 20),
        child: Column(
          children: [
            for (int i = 0; i < alternativas.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FittedBox(
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        if (ref.watch(isAtividadeEmptyNotifier)) {
                          ref.read(isAtividadeEmptyNotifier.notifier).state =
                              false;
                        }

                        Future.delayed(const Duration(milliseconds: 30), () {
                          ref
                              .read(alternativa.notifier)
                              .resetEstadosAndSetEstadoIndex(i, estado: true, allEstados: false);
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: hasValidAlternativaAtIndex(
                                    alternativas, i) &&
                                alternativas[i].estado
                            ? MaterialStateProperty.all<Color>(secondaryColor)
                            : MaterialStateProperty.all<Color>(primaryColor),
                      ),
                      child: Text(
                        hasValidAlternativaAtIndex(alternativas, i)
                            ? (alternativas[i].itemAtividade as Alternativa)
                                .descricao
                            : '',
                        style: TextStyle(
                            color:
                                hasValidAlternativaAtIndex(alternativas, i) &&
                                        alternativas[i].estado
                                    ? primaryColor
                                    : secondaryColor),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
