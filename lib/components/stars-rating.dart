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
      color: Colors.yellowAccent,
      size: 32,
      shadows: <Shadow>[Shadow(color: Colors.grey, blurRadius: 1.5)],
    );
  }
}
