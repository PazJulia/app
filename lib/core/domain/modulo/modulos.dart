import 'package:app/core/domain/estrela/estrela.dart';

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
    data['licoes'] = licoes.map((v) => v.toJson()).toList();
    data['cor'] = cor;
    return data;
  }
}

class Licoes {
  late int id;
  late String nome;
  late bool licaoIniciada;
  Estrela? estrela;

  Licoes({
    required this.id,
    required this.nome,
    required this.licaoIniciada,
    this.estrela,
  });

  Licoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    licaoIniciada = json['licaoIniciada'];
    estrela = json['estrela'] != null ? Estrela.fromJson(json['estrela']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['licaoIniciada'] = licaoIniciada;
    data['estrela'] = estrela != null ? estrela!.toJson() : null;
    return data;
  }
}