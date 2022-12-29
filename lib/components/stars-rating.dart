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
      color: Colors.yellow,
      size: 29,
      shadows: <Shadow>[Shadow(color: Colors.grey, blurRadius: 4.0)],
    );
  }
}
