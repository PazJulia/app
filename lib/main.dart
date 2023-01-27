import 'package:app/screens/formacao.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/pratica.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (context) => const Home(),
        '/formacao': (context) => const FormacaoCards(),
        '/pratica': (context) => const Pratica(),
      }
    );
  }
}
