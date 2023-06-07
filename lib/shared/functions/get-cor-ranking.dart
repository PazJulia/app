import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

Color getCorRanking(String ranking) {
  switch (ranking) {
    case 'DIAMANTE':
      return Colors.lightBlueAccent;
    case 'OURO':
      return Colors.yellow;
    case 'PRATA':
      return Colors.white70;
    case 'BRONZE':
      return Colors.deepOrangeAccent;
  }
  return primaryColor;
}