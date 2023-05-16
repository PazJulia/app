import 'package:flutter/material.dart';

import '../shared/values/colors.dart';

class Assiduidade extends StatelessWidget {
  const Assiduidade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Row(
        children: [
          quantidadeAssiduidade(),
          const SizedBox(width: 8),
          const Text(
            "Dias de Assiduidade",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }

  Widget quantidadeAssiduidade() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: eighthColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "3000",
        style: TextStyle(color: primaryColor, fontSize: 15),
      ),
    );
  }
}
