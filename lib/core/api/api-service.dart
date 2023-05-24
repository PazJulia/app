import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/shared/values/api-path.dart';

class ApiService {
  dynamic authorizedGet(String url,
      [Map<String, String> params = const {}]) async {
    var prefs = await SharedPreferences.getInstance();

    String authorization = (prefs.getString("authorization") ?? "");
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorization'
    };

    if (params != {}) {
      headers.addAll(params);
    }

    var response = await http.get(Uri.parse(apiPath + url), headers: headers);

    checkErrors(response.statusCode, url);

    return await json.decode(utf8.decode(response.bodyBytes));
  }

  dynamic get(String url, [Map<String, String> params = const {}]) async {
    final headers = {'accept': '*/*', 'Content-Type': 'application/json'};

    if (params != {}) {
      headers.addAll(params);
    }

    var response = await http.get(Uri.parse(apiPath + url), headers: headers);

    checkErrors(response.statusCode, url);

    return await json.decode(utf8.decode(response.bodyBytes));
  }

  dynamic authorizedPost(String url, Map body,
      [Map<String, String> params = const {}]) async {
    var prefs = await SharedPreferences.getInstance();

    String authorization = (prefs.getString("authorization") ?? "");
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorization'
    };

    var _body = json.encode(body);
    print("json enviado : $_body");

    var response = await http.post(Uri.parse(apiPath + url),
        headers: headers, body: _body);
    return response;
  }

  dynamic post(String url, Map body,
      [Map<String, String> params = const {}]) async {
    final headers = {'accept': '*/*', 'Content-Type': 'application/json'};

    var _body = json.encode(body);
    print("json enviado : $_body");

    var response = await http.post(Uri.parse(apiPath + url),
        headers: headers, body: _body);
    return response;
  }

  dynamic patch(String url, Map body,
      [Map<String, String> params = const {}]) async {
    var prefs = await SharedPreferences.getInstance();

    String authorization = (prefs.getString("authorization") ?? "");
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorization'
    };

    var _body = json.encode(body);
    print("json enviado : $_body");

    var response = await http.patch(Uri.parse(apiPath + url),
        headers: headers, body: _body);
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
    } else {
      log("Sucesso de conexão: $url");
    }
  }
}
