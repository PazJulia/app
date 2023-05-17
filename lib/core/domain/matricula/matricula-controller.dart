import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/matricula/matricula.dart';

class MatriculaController extends ApiService {
  Future<Matricula> getMatricula() async {
    Map<String, dynamic> response = await authorizedGet('matriculas/getByToken');
    return Matricula.fromJson(response);
  }
}