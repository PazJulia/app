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

  void resetEstadosAndSetEstadoIndex(int index, bool estado, bool allEstados) {
    state = state.map((e) => Atividade(codigo: e.codigo, estado: allEstados)).toList();
    state[index].estado = estado;
  }

  void setCodigos(List<String> codigos, estado) {
    state = codigos.map((e) => Atividade(codigo: e, estado: estado)).toList();
  }
}