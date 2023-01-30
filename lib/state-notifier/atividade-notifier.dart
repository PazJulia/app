import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/atividade.dart';

class AtividadeNotifier extends StateNotifier<List<Atividade>> {
  AtividadeNotifier({List<Atividade> codigos = const []}) : super(codigos);

  void changeEstado(int index, bool estado) {
    state[index].estado = estado;
  }

  void changeAllEstadosToFalse() {
    state = state.map((e) => Atividade(codigo: e.codigo, estado: false)).toList();
  }

  void changeEstados

  void setCodigos(List<String> codigos, buttonState) {
    state = codigos.map((e) => Atividade(codigo: e, estado: buttonState)).toList();
  }
}