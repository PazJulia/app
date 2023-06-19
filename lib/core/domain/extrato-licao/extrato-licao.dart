import '../estrela/estrela.dart';

class ExtratoLicao {
  int idLicao;
  String? dataHora;
  int? pontuacaoTotal;
  int? pontuacaoBonus;
  Estrela? estrela;
  List<int>? questoesCorretasIds;

  ExtratoLicao({
    required this.idLicao,
    this.dataHora,
    this.pontuacaoTotal,
    this.pontuacaoBonus,
    this.estrela,
    this.questoesCorretasIds
  });

  factory ExtratoLicao.fromJson(Map<String, dynamic> json) {
    return ExtratoLicao(
      idLicao: json['idLicao'] as int,
      dataHora: json['dataHora'] as String,
      pontuacaoTotal: json['pontuacaoTotal'] as int,
      pontuacaoBonus: json['pontuacaoBonus'] as int,
      estrela: json['estrela'] != null ? Estrela.fromJson(json['estrela'] as Map<String, dynamic>) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idLicao': idLicao,
      'questoesCorretasIds': questoesCorretasIds
    };
  }
}
