import 'package:app/state-notifier/atividade-codigo-notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/atividade-codigo.dart';
import '../shared/values/colors.dart';

final atividadeCodigoProvider = StateNotifierProvider.autoDispose<
    AtividadeCodigoNotifier,
    List<AtividadeCodigo>>((ref) => AtividadeCodigoNotifier());
final codigoResposta = StateProvider.autoDispose<List<String>>((ref) => []);
bool isCodigosProviderEmpty = true;

class AtividadeEscolhaCodigo extends ConsumerWidget {
  const AtividadeEscolhaCodigo(this.codes, {super.key});

  final List<String> codes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List<AtividadeCodigo> codigosList = ref.watch(atividadeCodigoProvider);
    List<String> resposta = ref.watch(codigoResposta);
    if (isCodigosProviderEmpty) {
      Future(() {
        ref.read(atividadeCodigoProvider.notifier).resetCodigos(codes);
        isCodigosProviderEmpty = false;
      });
    }
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
                          .resetCodigos(codes);
                      ref.read(codigoResposta.notifier).state = [];
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
                                ref
                                    .read(atividadeCodigoProvider.notifier)
                                    .changeEstadoToFalse(index);

                                resposta.add(codigosList[index].codigo);

                                ref.read(codigoResposta.notifier).state = [
                                  ...resposta
                                ];
                              },
                        style: ButtonStyle(
                          backgroundColor: codigosList[index].estado == true
                              ? MaterialStateProperty.all<Color>(secondaryColor)
                              : MaterialStateProperty.all<Color>(fifthColor),
                        ),
                        child: Text(
                          codigosList[index].codigo,
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
