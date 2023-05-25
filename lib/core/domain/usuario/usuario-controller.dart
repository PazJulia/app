import 'dart:convert';

import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/usuario/usuario.dart';
import 'package:app/shared/functions/extract-error-message.dart';
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
    String url = '/usuarios/editarNome/$nome';
    http.Response response = await patch(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Usuario usuarioResponse = Usuario.fromJson(data);
      return usuarioResponse;
    } else {
      return Future.error('Erro ao atualizar o nome');
    }
  }

  Future<Usuario> patchEmail(String email) async {
    String url = '/usuarios/editarEmail/$email';
    http.Response response = await patch(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Usuario usuarioResponse = Usuario.fromJson(data);
      return usuarioResponse;
    } else {

      return Future.error(extractErrorMessage(response.body));
    }
  }

  Future<Usuario> patchSenha(String senha) async {
    String url = '/usuarios/editarSenha/$senha';
    http.Response response = await patch(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Usuario usuarioResponse = Usuario.fromJson(data);
      return usuarioResponse;
    } else {
      return Future.error('Erro ao atualizar a senha');
    }
  }
}
