import 'package:app/state-notifier/atividade-codigo-notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/atividade-codigo.dart';
import '../shared/values/colors.dart';

const codigos = ['"', '"', ' = ', '(', ')', 'string python', 'x'];
final atividadeCodigoProvider =
    StateNotifierProvider((ref) => AtividadeCodigoNotifier());

class AtividadeEscolhaCodigo extends ConsumerWidget {
  const AtividadeEscolhaCodigo({super.key, codigos});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var codigo in codigos) {
      ref
          .read(atividadeCodigoProvider.notifier)
          .add(AtividadeCodigo(codigo: codigo, estado: true));
    }
    var codigoResposta = [];
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
                      codigoResposta.join(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      ref.read(atividadeCodigoProvider.notifier).reset();
                      for (var codigo in codigos) {
                        ref
                            .read(atividadeCodigoProvider.notifier)
                            .add(AtividadeCodigo(codigo: codigo, estado: true));
                      }
                      codigoResposta = [];
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
                ref.watch(atividadeCodigoProvider.notifier).state.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(7),
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: (ref
                                    .watch(atividadeCodigoProvider.notifier)
                                    .state[index]
                                    .estado ==
                                false)
                            ? null
                            : () {
                                ref
                                    .read(atividadeCodigoProvider.notifier)
                                    .changeState(index);
                              },
                        style: ButtonStyle(
                          backgroundColor: ref
                                      .watch(atividadeCodigoProvider.notifier)
                                      .state[index]
                                      .estado ==
                                  true
                              ? MaterialStateProperty.all<Color>(secondaryColor)
                              : MaterialStateProperty.all<Color>(fifthColor),
                        ),
                        child: Text(
                          ref
                              .watch(atividadeCodigoProvider.notifier)
                              .state[index]
                              .codigo,
                          style: TextStyle(
                              color: ref
                                          .watch(
                                              atividadeCodigoProvider.notifier)
                                          .state[index]
                                          .estado ==
                                      true
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
