import 'package:app/core/domain/model/atividade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/domain/licao/sequencia.dart';
import '../screens/pratica.dart';
import '../shared/values/colors.dart';
import '../state-notifier/atividade-notifier.dart';

final atividadeCodigoProvider =
    StateNotifierProvider.autoDispose<AtividadeNotifier, List<Atividade>>(
        (ref) => AtividadeNotifier());
final respostaCodigo = StateProvider.autoDispose<List<String>>((ref) => []);

class AtividadeEscolhaCodigo extends ConsumerWidget {
  const AtividadeEscolhaCodigo(this.codes, {super.key});

  final List<Sequencia> codes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Atividade> codigosList = ref.watch(atividadeCodigoProvider);
    List<String> resposta = ref.watch(respostaCodigo);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      resposta.join(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      ref
                          .read(atividadeCodigoProvider.notifier)
                          .setActivity(codes, true);
                      ref.read(respostaCodigo.notifier).state = [];
                      ref.read(isAtividadeEmptyNotifier.notifier).state = true;
                    },
                    color: secondaryColor,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                codigosList.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(7),
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: (codigosList[index].estado == false)
                            ? null
                            : () {
                                if (ref.watch(isAtividadeEmptyNotifier)) {
                                  ref
                                      .read(isAtividadeEmptyNotifier.notifier)
                                      .state = false;
                                }
                                Future.delayed(const Duration(milliseconds: 30),
                                    () {
                                  ref
                                      .read(atividadeCodigoProvider.notifier)
                                      .changeEstado(index, false);

                                  resposta.add((codigosList[index].itemAtividade
                                          as Sequencia)
                                      .nome);
                                  ref.read(respostaCodigo.notifier).state = [
                                    ...resposta
                                  ];
                                });
                              },
                        style: ButtonStyle(
                          backgroundColor: codigosList[index].estado == true
                              ? MaterialStateProperty.all<Color>(secondaryColor)
                              : MaterialStateProperty.all<Color>(fifthColor),
                        ),
                        child: Text(
                          (codigosList[index].itemAtividade as Sequencia).nome,
                          style: TextStyle(
                              color: codigosList[index].estado == true
                                  ? primaryColor
                                  : Colors.transparent),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
