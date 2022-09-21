import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('TESTE', style: TextStyle(color: Colors.white),),
      ),
    );
  }

  _body(BuildContext context) {
    return const Padding(padding: EdgeInsets.only(right: 50.0, left: 50.0),);
  }
}