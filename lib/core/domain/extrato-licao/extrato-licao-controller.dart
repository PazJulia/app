import 'package:app/core/domain/extrato-licao/extrato-licao.dart';
import 'package:http/http.dart' as http;

import 'package:app/core/api/api-service.dart';

class ModulosController extends ApiService {
  Future<http.Response> postExtratoLicao(ExtratoLicao extrato) async {
    Map<String, dynamic> requestBody = extrato.toJson();
    http.Response response = await post('extratoslicao', requestBody); // Use 'body' parameter

    return response;
  }
}
