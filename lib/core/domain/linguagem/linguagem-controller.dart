import 'package:app/core/api/api-service.dart';
import 'package:app/core/domain/linguagem/linguagem.dart';

class LinguagemController extends ApiService {
  Future<List<Linguagem>> listLinguagens() async {
    List response = await get('linguagens');
    List<Linguagem> linguagens = response.map((json) => Linguagem.fromJson(json)).toList();
    return linguagens;
  }

  Future<List<Linguagem>> listLinguagensByUsuario() async {
    List response = await authorizedGet('linguagens/getAllByUsuario');
    List<Linguagem> linguagens = response.map((json) => Linguagem.fromJson(json)).toList();
    return linguagens;
  }
}