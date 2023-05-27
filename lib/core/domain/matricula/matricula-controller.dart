import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/matricula/matricula.dart';

import '../../../shared/functions/get-current-date-time-utc.dart';

class MatriculaController extends ApiService {
  Future<Matricula> getMatricula() async {
    String dataHora = getCurrentDateTimeUtc();
    String encodedDataHora = Uri.encodeComponent(dataHora);

    Map<String, dynamic> response = await authorizedGet('matriculas/getByToken/$encodedDataHora');

    return Matricula.fromJson(response);
  }
}