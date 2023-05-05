import 'package:flutter/material.dart';

import '../core/domain/estrela/estrela.dart';

class StarsRating extends StatelessWidget {
  const StarsRating({super.key, required this.estrela});

  final Estrela? estrela;

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
        for (var i = 0; i < 3; i++) star(i, quantidadeEstrelas),
      ],
    );
  }

  Widget star(int i, int estrelas) {
    if (i < estrelas) {
      return const Icon(
        Icons.star_rounded,
        color: Colors.amberAccent,
        size: 32,
        shadows: <Shadow>[Shadow(color: Colors.orange, blurRadius: 2)],
      );
    }
    return const Icon(Icons.star_outline_rounded, color: Colors.black45, size: 32);
  }
}
