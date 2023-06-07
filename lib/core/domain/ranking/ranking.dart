class Ranking {
  final bool usuarioPrincipal;
  final String nomeUsuario;
  final int pontuacaoSemanal;
  final String ranking;

  Ranking({
    required this.usuarioPrincipal,
    required this.nomeUsuario,
    required this.pontuacaoSemanal,
    required this.ranking,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) {
    return Ranking(
      usuarioPrincipal: json['usuarioPrincipal'],
      nomeUsuario: json['nomeUsuario'],
      pontuacaoSemanal: json['pontuacaoSemanal'],
      ranking: json['ranking'],
    );
  }
}
