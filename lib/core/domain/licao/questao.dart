import 'package:app/core/domain/licao/alternativa.dart';
import 'package:app/core/domain/licao/comando.dart';

class Questao {
  int id;
  String textoInicial;
  String pergunta;
  String tipo;
  List<Alternativa>? alternativas;
  List<Comando>? comandos;

  Questao({
    required this.id,
    required this.textoInicial,
    required this.pergunta,
    required this.tipo,
    this.alternativas,
    this.comandos,
  });

  factory Questao.fromJson(Map<String, dynamic> json) {
    List<Object?>? result = mapQuestaoPorTipo(json);
    return Questao(
      id: json['id'],
      textoInicial: json['textoInicial'],
      pergunta: json['pergunta'],
      tipo: json['tipo'],
      alternativas: result?[0] as List<Alternativa>?,
      comandos: result?[1] as List<Comando>?,
    );
  }

  static List<Object?>? mapQuestaoPorTipo(Map<String, dynamic> json) {
    if (json['tipo'] == 'PerguntaResposta') {
      var alternativas = json['alternativas'] as List?;
      if (alternativas != null) {
        List<Alternativa> alternativaList =
        alternativas.map((e) => Alternativa.fromJson(e)).toList();
        return [alternativaList, null];
      }
    } else if (json['tipo'] == 'Programacao') {
      var comandos = json['comandos'] as List?;
      if (comandos != null) {
        List<Comando> comandoList =
        comandos.map((e) => Comando.fromJson(e)).toList();
        return [null, comandoList];
      }
    }
    return null;
  }
}

