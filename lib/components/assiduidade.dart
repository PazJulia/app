import 'package:app/core/domain/matricula/matricula.dart';
import 'package:flutter/material.dart';

import '../shared/values/colors.dart';

class Assiduidade extends StatelessWidget {
  const Assiduidade(this.matricula, {Key? key}) : super(key: key);

  final Matricula matricula;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Row(
        children: [
          quantidadeAssiduidade(matricula.assiduidade),
          const SizedBox(width: 8),
          const Text(
            "Dias de Assiduidade",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  Widget quantidadeAssiduidade(int assiduidade) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: fourthColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        assiduidade.toString(),
        style: TextStyle(color: primaryColor, fontSize: 15),
      ),
    );
  }
}
