import 'package:app/core/domain/linguagem/linguagem.dart';

class Matricula {
  int id;
  String data;
  int assiduidade;
  int assiduidadeSemanal;
  int assiduidadeMensal;
  int totalPontuacao;
  Linguagem linguagem;
  Usuario usuario;

  Matricula({
    required this.id,
    required this.data,
    required this.assiduidade,
    required this.assiduidadeSemanal,
    required this.assiduidadeMensal,
    required this.totalPontuacao,
    required this.linguagem,
    required this.usuario,
  });

  factory Matricula.fromJson(Map<String, dynamic> json) {
    return Matricula(
      id: json['id'],
      data: json['data'],
      assiduidade: json['assiduidade'],
      assiduidadeSemanal: json['assiduidadeSemanal'],
      assiduidadeMensal: json['assiduidadeMensal'],
      totalPontuacao: json['totalPontuacao'],
      linguagem: Linguagem.fromJson(json['linguagem']),
      usuario: Usuario.fromJson(json['usuario']),
    );
  }
}

class Usuario {
  String nome;
  String email;

  Usuario({
    required this.nome,
    required this.email,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      email: json['email'],
    );
  }
}
