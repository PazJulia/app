import 'package:app/core/domain/linguagem/linguagem.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

guardarLinguagemRedirecionar(int idLinguagem, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt("language", idLinguagem);
  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
}