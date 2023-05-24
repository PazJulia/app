import 'dart:convert';

import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/usuario/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioController extends ApiService {
  Future<Usuario> getLoggedUser() async {
    http.Response response = await authorizedGet('auth/usuario');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Usuario usuarioResponse = Usuario.fromJson(data);
      return usuarioResponse;
    } else {
      return Future.error('Erro ao buscar o usuário logado');
    }
  }

  Future<Usuario> patchNome(String nome) async {
    Map<String, dynamic> requestBody = {"nome": nome};
    http.Response response = await patch('usuarios/editarNome', requestBody);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Usuario usuarioResponse = Usuario.fromJson(data);
      return usuarioResponse;
    } else {
      return Future.error('Erro ao atualizar o nome');
    }
  }

  Future<Usuario> patchEmail(String email) async {
    Map<String, dynamic> requestBody = {"email": email};
    http.Response response = await patch('usuarios/editarEmail', requestBody);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Usuario usuarioResponse = Usuario.fromJson(data);
      return usuarioResponse;
    } else {
      return Future.error('Erro ao atualizar o e-mail');
    }
  }

  Future<Usuario> patchSenha(String senha) async {
    Map<String, dynamic> requestBody = {"senha": senha};
    http.Response response = await patch('usuarios/editarSenha', requestBody);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Usuario usuarioResponse = Usuario.fromJson(data);
      return usuarioResponse;
    } else {
      return Future.error('Erro ao atualizar a senha');
    }
  }
}
