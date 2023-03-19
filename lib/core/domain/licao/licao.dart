import 'package:app/core/domain/licao/questao.dart';

class Licao {
  int id;
  String nome;
  List<String> explicacao;
  List<Questao> questoes;

  Licao(
      {required this.id,
      required this.nome,
      required this.explicacao,
      required this.questoes});

  factory Licao.fromJson(Map<String, dynamic> json) {
    var questoes = json['questoes'] as List;
    List<Questao> questionList =
        questoes.map((e) => Questao.fromJson(e)).toList();
    return Licao(
      id: json['id'],
      nome: json['nome'],
      explicacao: List<String>.from(json['explicacao']),
      questoes: questionList,
    );
  }
}
