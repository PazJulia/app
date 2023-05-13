import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/modulo/modulos.dart';

class ModulosController extends ApiService {
  Future<List<Modulos>> modulosList() async {
    List response = await authorizedGet('modulos/allByUsuario');

    var parse = response;

    List<Modulos> modulos = parse.map((json) => Modulos.fromJson(json)).toList();
    return modulos;
  }
}