import 'dart:convert';

import 'package:app/core/domain/extrato-licao/extrato-licao.dart';
import 'package:http/http.dart' as http;

import 'package:app/core/api/api-service.dart';

class ExtratoLicaoController extends ApiService {
  Future<ExtratoLicao> postExtratoLicao(ExtratoLicao extrato) async {
    Map<String, dynamic> requestBody = extrato.toJson();
    http.Response response = await post('extratoslicao', requestBody);

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      ExtratoLicao extratoResponse = ExtratoLicao.fromJson(data);
      return extratoResponse;
    } else {
      throw Exception('Erro ao verificar a lição');
    }
  }
}
