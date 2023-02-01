import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/atividade.dart';
import '../screens/pratica.dart';
import '../state-notifier/atividade-notifier.dart';

final atividadeEscolhaComandos =
    StateNotifierProvider.autoDispose<AtividadeNotifier, List<Atividade>>(
        (ref) => AtividadeNotifier());

class AtividadeEscolhaComandos extends ConsumerWidget {
  const AtividadeEscolhaComandos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Atividade> comandosList = ref.watch(atividadeEscolhaComandos);
    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 30, right: 20, bottom: 5, left: 20),
      child: GridView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => SizedBox(
          height: 20,
          child: ElevatedButton(
            onPressed: () {
              if (ref.watch(isAtividadeEmptyNotifier)) {
                ref.read(isAtividadeEmptyNotifier.notifier).state = false;
              }

              Future.delayed(const Duration(milliseconds: 30), () {
                ref
                    .read(atividadeEscolhaComandos.notifier)
                    .resetEstadosAndSetEstadoIndex(index, true, false);
              });
            },
            style: ButtonStyle(
              backgroundColor: comandosList[index].estado == true
                  ? MaterialStateProperty.all<Color>(secondaryColor)
                  : MaterialStateProperty.all<Color>(primaryColor),
            ),
            child: Text(
              comandosList[index].codigo,
              style: TextStyle(
                  color: comandosList[index].estado == true
                      ? primaryColor
                      : secondaryColor),
            ),
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 6 / 2,
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
