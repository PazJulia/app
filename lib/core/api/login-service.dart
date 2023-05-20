import 'dart:convert';

import 'package:app/screens/escolha-linguagem.dart';
import 'package:app/screens/home.dart';
import 'package:app/shared/values/api-path.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../screens/login.dart';
import '../domain/authorization.dart';

class LoginApi {
  LoginApi();

  static Future<Authorization> login(String email, String password) async {
    const String url = "${apiPath}auth";
    final Map<String, dynamic> body = {"email": email, "senha": password};
    final headers = {'accept': '*/*', 'Content-Type': 'application/json'};

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      String? authorizationToken = response.headers["authorization"];
      if (authorizationToken != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("authorization", authorizationToken);
        return Authorization(authorization: authorizationToken);
      } else {
        return Future.error("Não foi possível obter o token de acesso");
      }
    } else if (response.statusCode == 500) {
      return Future.error("Erro interno do servidor");
    } else {
      return Future.error("Não foi possível realizar o login");
    }
  }

  Future<Widget> getHome() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString("authorization") != null) {
      String authorization = (prefs.getString("authorization") ?? "");
      int? linguagem = (prefs.getInt("language"));
      bool isValid = await isTokenValid(authorization);
      if (isValid && linguagem != null) {
        return const Home();
      } else if (linguagem == null) {
        return const EscolhaLinguagem();
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        return const Login();
      }
    } else {
      return const Login();
    }
  }

  static Future logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<bool> isTokenValid(String authorization) async {
    bool isExpired = JwtDecoder.isExpired(authorization);

    return !isExpired;
  }
}
