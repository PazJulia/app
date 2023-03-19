class Comando {
  int sequencia;
  String nome;

  Comando({required this.sequencia, required this.nome});

  factory Comando.fromJson(Map<String, dynamic> json) {
    return Comando(
      sequencia: json['sequencia'],
      nome: json['nome'],
    );
  }
}
