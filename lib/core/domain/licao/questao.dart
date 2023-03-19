import 'package:app/core/domain/licao/alternativa.dart';
import 'package:app/core/domain/licao/comando.dart';

class Questao {
  int id;
  String textoInicial;
  String pergunta;
  String tipo;
  List<Alternativa> alternativas;
  List<Comando> comandos;

  Questao(
      {required this.id,
      required this.textoInicial,
      required this.pergunta,
      required this.tipo,
      required this.alternativas,
      required this.comandos});

  factory Questao.fromJson(Map<String, dynamic> json) {
    var alternativas = json['alternativas'] as List;
    List<Alternativa> alternativaList =
        alternativas.map((e) => Alternativa.fromJson(e)).toList();

    var comandos = json['comandos'] as List;
    List<Comando> comandoList =
        comandos.map((e) => Comando.fromJson(e)).toList();

    return Questao(
      id: json['id'],
      textoInicial: json['textoInicial'],
      pergunta: json['pergunta'],
      tipo: json['tipo'],
      alternativas: alternativaList,
      comandos: comandoList,
    );
  }
}
