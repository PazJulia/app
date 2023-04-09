import 'package:flutter/material.dart';

Widget untouchableBackground() {
  return GestureDetector(
    onTap: () {}, // Consume touch events
    child: Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.5), // Semi-transparent background color
    ),
  );
}
