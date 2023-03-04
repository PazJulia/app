import 'package:app/screens/formacao.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/pratica.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/api/login-service.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var loginApi = LoginApi();

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/': (context) => FutureBuilder(
              future: loginApi.getHome(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          '/formacao': (context) => const FormacaoCards(),
          '/pratica': (context) => const Pratica(),
        });
  }
}
