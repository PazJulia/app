class Modulos {
  late int id;
  late String nome;
  late String descricao;
  late List<Licoes> licoes;
  late String cor;

  Modulos({required this.id, required this.nome, required this.descricao, required this.licoes, required this.cor});

  Modulos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    if (json['licoes'] != null) {
      licoes = <Licoes>[];
      json['licoes'].forEach((v) {
        licoes.add(Licoes.fromJson(v));
      });
    }
    cor = json['cor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['descricao'] = descricao;
    if (licoes != null) {
      data['licoes'] = licoes.map((v) => v.toJson()).toList();
    }
    data['cor'] = cor;
    return data;
  }
}

class Licoes {
  late int id;
  late String nome;

  Licoes({required this.id, required this.nome});

  Licoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    return data;
  }
}