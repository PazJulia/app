import 'dart:ui';

Color convertToColor(String color) {
  return Color(int.parse(color.substring(1), radix: 16) + 0xFF000000);
}