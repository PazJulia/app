import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/atividade-codigo.dart';

class AtividadeCodigoNotifier extends StateNotifier<List<AtividadeCodigo>> {
  AtividadeCodigoNotifier() : super([]);

  void add(AtividadeCodigo atividadeCodigo) {
    state = [...state, atividadeCodigo];
  }

  void changeState(int index) {
    state = [
      ...state.sublist(0, index),
      AtividadeCodigo(codigo: state[index].codigo, estado: !state[index].estado),
      ...state.sublist(index + 1),
    ];
  }

  void reset() {
    state = [];
  }
}