class Linguagem {
  int id;
  String nome;

  Linguagem({
    required this.id,
    required this.nome,
  });

  factory Linguagem.fromJson(Map<String, dynamic> json) {
    return Linguagem(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
    };
  }
}