import 'dart:convert';

import 'package:app/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../screens/login.dart';
import '../domain/authorization.dart';

class LoginApi {
  LoginApi();

  static Future<Authorization> login(String email, String password) async {
    const String url = "http://10.0.0.106:8080/auth";
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
    } else {
      return Future.error("Erro durante a autenticação");
    }
  }

  Future<Widget> getHome() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString("authorization") != null) {
      return const Home();
    } else {
      return const Login();
    }
  }

  static Future<Widget?> logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
