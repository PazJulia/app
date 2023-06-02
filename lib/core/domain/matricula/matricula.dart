import 'package:app/core/domain/linguagem/linguagem.dart';
import 'package:app/core/domain/usuario/usuario.dart';

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
      data: json['data'] ?? '',
      assiduidade: json['assiduidade'] ?? 0,
      assiduidadeSemanal: json['assiduidadeSemanal'] ?? 0,
      assiduidadeMensal: json['assiduidadeMensal'] ?? 0,
      totalPontuacao: json['totalPontuacao'] ?? 0,
      linguagem: Linguagem.fromJson(json['linguagem']),
      usuario: Usuario.fromJson(json['usuario']),
    );
  }
}
