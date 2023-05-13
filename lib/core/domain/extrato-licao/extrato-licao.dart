import '../estrela/estrela.dart';

class ExtratoLicao {
  int idLicao;
  String dataHora;
  int pontuacaoTotal;
  int pontuacaoBonus;
  Estrela? estrela;

  ExtratoLicao({
    required this.idLicao,
    required this.dataHora,
    required this.pontuacaoTotal,
    required this.pontuacaoBonus,
    this.estrela
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
      'dataHora': dataHora,
      'pontuacaoTotal': pontuacaoTotal,
      'pontuacaoBonus': pontuacaoBonus,
      'estrela': estrela?.toJson()
    };
  }
}
