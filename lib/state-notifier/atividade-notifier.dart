import 'package:app/core/domain/model/atividade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AtividadeNotifier extends StateNotifier<List<Atividade>> {
  AtividadeNotifier({List<Atividade> codigos = const []}) : super(codigos);

  void changeEstado(int index, bool estado) {
    state[index].estado = estado;
  }

  /*void changeAllEstadosToFalse() {
    state = state.map((e) => Atividade(itemAtividade: e.itemAtividade, estado: false)).toList();
  }*/

  void resetEstadosAndSetEstadoIndex(int index, {required bool estado, required bool allEstados}) {
    state = state.map((e) => Atividade(itemAtividade: e.itemAtividade, estado: allEstados)).toList();
    state[index].estado = estado;
  }

  void setActivity(List<dynamic> activityItem, estado) {
    state = activityItem.map((e) => Atividade(itemAtividade: e, estado: estado)).toList();
  }
}