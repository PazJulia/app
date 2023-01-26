import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/atividade-codigo.dart';

class AtividadeCodigoNotifier extends StateNotifier<List<AtividadeCodigo>> {
  AtividadeCodigoNotifier({List<AtividadeCodigo> codigos = const []}) : super(codigos);

  void changeEstadoToFalse(int index) {
    state = [
      ...state.sublist(0, index),
      AtividadeCodigo(codigo: state[index].codigo, estado: false),
      ...state.sublist(index + 1),
    ];
  }

  void resetCodigos(List<String> codigos) {
    state = codigos.map((e) => AtividadeCodigo(codigo: e, estado: true)).toList();
  }
}