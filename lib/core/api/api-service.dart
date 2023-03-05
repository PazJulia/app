import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String apiPath = 'http://10.0.0.106:8080/';

  dynamic get(String url, [Map<String, String> params = const {} ]) async {
    var prefs = await SharedPreferences.getInstance();

    String authorization = (prefs.getString("authorization") ?? "");

    var headers = {"Authorization": "Bearer $authorization"};

    if (params != {}) {
      headers.addAll(params);
    }

    var response = await http.get(Uri.parse(apiPath + url), headers: headers);

    checkErrors(response.statusCode, url);

    return await json.decode(utf8.decode(response.bodyBytes));
  }

  dynamic post(String url, Map id, [Map<String, String> params = const {}]) async {
    var prefs = await SharedPreferences.getInstance();

    String authorization = (prefs.getString("authorization") ?? "");

    var headers = {
      "Authorization": "Bearer $authorization",
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var _body = json.encode(id);
    print("json enviado : $_body");

    var response =
    await http.post(Uri.parse(apiPath + url), headers: headers, body: _body);
    return response;
  }

  checkErrors(int statusCode, String url) {
    if (statusCode != 200) {
      switch (statusCode) {
        case 404:
          Exception("Não encontrado");
          break;

        default:
          Exception("Erro");
          break;
      }
    }
    log("Sucesso de conexão: $url");
  }
}
