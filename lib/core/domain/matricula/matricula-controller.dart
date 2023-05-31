import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/matricula/matricula.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/functions/get-current-date-time-utc.dart';

class MatriculaController extends ApiService {
  Future<Matricula> getMatricula() async {
    String dataHora = getCurrentDateTimeUtc();
    String encodedDataHora = Uri.encodeComponent(dataHora);
    var prefs = await SharedPreferences.getInstance();
    int? linguagemId = (prefs.getInt("language"));

    Map<String, dynamic> response = await authorizedGet('matriculas/getByToken/$encodedDataHora/$linguagemId');

    return Matricula.fromJson(response);
  }
}