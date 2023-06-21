import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

import '../core/domain/estrela/estrela.dart';

class StarsRating extends StatelessWidget {
  const StarsRating({super.key, required this.estrela, required this.isDark});

  final Estrela? estrela;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    int quantidadeEstrelas;

    if (estrela == null) {
      quantidadeEstrelas = 0;
    } else {
      quantidadeEstrelas = estrela!.quantidade;
    }

    return Row(
      children: [
        for (var i = 0; i < 3; i++) star(i, quantidadeEstrelas, isDark),
      ],
    );
  }

  Widget star(int i, int estrelas, bool isDark) {
    if (i < estrelas) {
      return const Icon(
        Icons.star_rounded,
        color: Colors.amberAccent,
        size: 32,
        shadows: <Shadow>[Shadow(color: Colors.deepOrangeAccent, blurRadius: 4)],
      );
    }
    // return const Icon(Icons.star_outline_rounded, color: Colors.black26, size: 32);
    return Icon(Icons.star_rounded, color: isDark ? Colors.white54 : seventhColor, size: 32);
  }
}
