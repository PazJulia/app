class Alternativa {
  int id;
  bool verdadeira;
  String descricao;
  String explicacao;

  Alternativa({
      required this.id,
      required this.verdadeira,
      required this.descricao,
      required this.explicacao});

  factory Alternativa.fromJson(Map<String, dynamic> json) {
    return Alternativa(
      id: json['id'],
      verdadeira: json['verdadeira'],
      descricao: json['descricao'],
      explicacao: json['explicacao'],
    );
  }
}
