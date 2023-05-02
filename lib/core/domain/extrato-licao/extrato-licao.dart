class ExtratoLicao {
  int idLicao;
  String dataHora;
  int pontuacaoTotal;
  int pontuacaoBonus;
  String email;

  ExtratoLicao({
    required this.idLicao,
    required this.dataHora,
    required this.pontuacaoTotal,
    required this.pontuacaoBonus,
    required this.email,
  });

  factory ExtratoLicao.fromJson(Map<String, dynamic> json) {
    return ExtratoLicao(
      idLicao: json['idLicao'] as int,
      dataHora: json['dataHora'] as String,
      pontuacaoTotal: json['pontuacaoTotal'] as int,
      pontuacaoBonus: json['pontuacaoBonus'] as int,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idLicao': idLicao,
      'dataHora': dataHora,
      'pontuacaoTotal': pontuacaoTotal,
      'pontuacaoBonus': pontuacaoBonus,
      'email': email,
    };
  }
}
