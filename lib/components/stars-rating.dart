import 'package:flutter/material.dart';

class StarsRating extends StatelessWidget {
  const StarsRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        star(),
        star(),
        star(),
      ],
    );
  }

  Widget star() {
    return const Icon(
      Icons.star_rate_rounded,
      color: Colors.amberAccent,
      size: 32,
      shadows: <Shadow>[Shadow(color: Colors.orange, blurRadius: 2)],
    );
  }
}
