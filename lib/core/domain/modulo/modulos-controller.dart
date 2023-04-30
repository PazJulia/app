import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/modulo/modulos.dart';

class ModulosController extends ApiService {
  Future<List<Modulos>> modulosList() async {
    List response = await get('modulos/allByUsuario?email=jon%40gmail.com'); // pegar pelo token

    var parse = response;

    List<Modulos> modulos = parse.map((json) => Modulos.fromJson(json)).toList();
    return modulos;
  }
}