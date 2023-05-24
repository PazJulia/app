import 'package:flutter/material.dart';

class MessageDisplay {
  static void show(String message, BuildContext context, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? Theme.of(context).snackBarTheme.backgroundColor,
        duration: const Duration(seconds: 10),
      ),
    );
  }
}
