import 'package:app/core/domain/licao/alternativa.dart';
import 'package:app/core/domain/licao/sequencia.dart';

import '../model/tipo-atividade.dart';

class Questao {
  int id;
  String textoInicial;
  String pergunta;
  String tipo;
  List<Alternativa>? alternativas;
  List<Sequencia>? sequencias;

  Questao({
    required this.id,
    required this.textoInicial,
    required this.pergunta,
    required this.tipo,
    this.alternativas,
    this.sequencias,
  });

  factory Questao.fromJson(Map<String, dynamic> json) {
    List<Object?>? result = mapQuestaoPorTipo(json);
    return Questao(
      id: json['id'],
      textoInicial: json['textoInicial'],
      pergunta: json['pergunta'],
      tipo: json['tipo'],
      alternativas: result?[0] as List<Alternativa>?,
      sequencias: result?[1] as List<Sequencia>?,
    );
  }

  static List<Object?>? mapQuestaoPorTipo(Map<String, dynamic> json) {
    if (json['tipo'] == TipoAtividade.perguntaResposta.name) {
      var alternativas = json['alternativas'] as List?;
      if (alternativas != null) {
        List<Alternativa> alternativaList =
        alternativas.map((e) => Alternativa.fromJson(e)).toList();
        return [alternativaList, null];
      }
    } else if (json['tipo'] == TipoAtividade.programacao.name) {
      var sequencias = json['sequencias'] as List?;
      if (sequencias != null) {
        List<Sequencia> sequenciasList =
        sequencias.map((e) => Sequencia.fromJson(e)).toList();
        return [null, sequenciasList];
      }
    }
    return null;
  }
}

