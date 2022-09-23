import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('TESTE', style: TextStyle(color: Colors.black),),
      ),
      body: _body(context),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined, size: 30), label: 'CONQUISTAS'),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 30), label: 'INÍCIO'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard_outlined, size: 30), label: 'CLASSIFICAÇÃO')
        ],
      ),
    );
  }

  _body(BuildContext context) {
    return const Padding(padding: EdgeInsets.only(right: 50.0, left: 50.0),);
  }
}