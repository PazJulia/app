class Sequencia {
  int sequencia;
  String nome;

  Sequencia({required this.sequencia, required this.nome});

  factory Sequencia.fromJson(Map<String, dynamic> json) {
    return Sequencia(
      sequencia: json['sequencia'],
      nome: json['nome'],
    );
  }
}
