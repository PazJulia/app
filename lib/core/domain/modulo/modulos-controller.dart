import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/modulo/modulos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModulosController extends ApiService {
  Future<List<Modulos>> modulosList() async {
    var prefs = await SharedPreferences.getInstance();
    int? linguagemId = (prefs.getInt("language"));
    List response = await authorizedGet('modulos/allByUsuarioLogado/$linguagemId');

    List<Modulos> modulos = response.map((json) => Modulos.fromJson(json)).toList();
    return modulos;
  }
}