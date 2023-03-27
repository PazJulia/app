import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/core/domain/model/atividade.dart';
import '../screens/pratica.dart';
import '../state-notifier/atividade-notifier.dart';

final atividadeAlternativa =
    StateNotifierProvider.autoDispose<AtividadeNotifier, List<Atividade>>(
        (ref) => AtividadeNotifier());

class AtividadeAlternativa extends ConsumerWidget {
  const AtividadeAlternativa({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Atividade> alternativasList = ref.watch(atividadeAlternativa);
    return Expanded(
      child: Container(
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
                      .read(atividadeAlternativa.notifier)
                      .resetEstadosAndSetEstadoIndex(index, true, false);
                });
              },
              style: ButtonStyle(
                backgroundColor: alternativasList[index].estado == true
                    ? MaterialStateProperty.all<Color>(secondaryColor)
                    : MaterialStateProperty.all<Color>(primaryColor),
              ),
              child: Text(
                alternativasList[index].codigo,
                style: TextStyle(
                    color: alternativasList[index].estado == true
                        ? primaryColor
                        : secondaryColor),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 7 / 1,
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
          ),
        ),
      ),
    );
  }
}
