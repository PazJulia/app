import 'dart:convert';

import 'package:app/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../screens/login.dart';
import '../domain/access.dart';

class LoginApi {
  LoginApi();

  static Future<Access> login(String user, String password) async {
    var url = 'http://10.0.0.106/auth';

    var header = {"Content-Type": "application/json"};

    Map params = {"email": user, "senha": password};

    var acesso;

    var prefs = await SharedPreferences.getInstance();

    var body = json.encode(params);
    print("json enviado : $body");

    var response = await http.post(Uri.parse(url), headers: header, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      acesso = Access.fromJson(mapResponse as Map<String, dynamic>);
      prefs.setString("access", mapResponse["access"]);
    } else {
      acesso = null;
    }
    return acesso;
  }

  Future<Widget> getHome() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString("access") != null) {
      return const Home();
    } else {
      return const Login();
    }
  }

  static Future<Widget> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return const Login();
  }
}
