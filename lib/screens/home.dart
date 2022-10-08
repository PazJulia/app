import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: const Color.fromARGB(4, 0, 0, 0),
        title: const Text('Teste', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.emoji_events_sharp),
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Conquistas',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.school_sharp),
            icon: Icon(Icons.school_outlined),
            label: 'Formação',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.leaderboard_sharp),
            icon: Icon(Icons.leaderboard_outlined),
            label: 'Divisão',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 133, 145, 255),
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}