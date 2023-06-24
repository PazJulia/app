import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/licao/licao.dart';

class LicaoController extends ApiService {
  Future<Licao> listLicao(int idLicao) async {
    Map<String, dynamic> response = await authorizedGet('licoes/$idLicao');
    return Licao.fromJson(response);
  }
}