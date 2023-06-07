import 'dart:convert';

import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/matricula/matricula.dart';
import 'package:app/core/domain/ranking/ranking.dart';
import 'package:app/shared/values/api-path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MatriculaController extends ApiService {
  Future<Matricula> getMatricula() async {
    var prefs = await SharedPreferences.getInstance();
    int? linguagemId = (prefs.getInt("language"));

    Map<String, dynamic> response =
        await authorizedGet('matriculas/usuarioLogado/$linguagemId');

    return Matricula.fromJson(response);
  }

  Future<Matricula> createMatricula(int linguagemId) async {
    var prefs = await SharedPreferences.getInstance();

    String? authorization = prefs.getString("authorization");
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorization'
    };

    final response = await http.post(
      Uri.parse('${apiPath}matriculas/$linguagemId'),
      headers: headers,
    );

    Map<String, dynamic> responseData = jsonDecode(response.body);
    return Matricula.fromJson(responseData);
  }

  Future<List<Ranking>> getRankingUsuario() async {
    var prefs = await SharedPreferences.getInstance();
    int? linguagemId = (prefs.getInt("language"));
    String? authorization = prefs.getString("authorization");
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorization'
    };

    var response = await http.get(
        Uri.parse('${apiPath}matriculas/rankingUsuarioLogado/$linguagemId'),
        headers: headers); //http.get(Uri.parse(url));

    if (response.statusCode == 204) {
      return [];
    }

    List<dynamic> jsonResponse = json.decode(response.body);
    List<Ranking> ranking =
        jsonResponse.map((json) => Ranking.fromJson(json)).toList();

    return ranking;
  }
}
