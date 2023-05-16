import 'package:app/components/user-detail.dart';
import 'package:app/core/api/login-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/values/colors.dart';
import 'formacao.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    /*Text(
      'Index 0: Home',
      style: optionStyle,
    ),*/
    FormacaoCards(),
    Text(
      'Divisão',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isDetailTapped = false;

  @override
  Widget build(BuildContext context) {
    LoginApi();
    return Scaffold(
      backgroundColor: fifthColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: const Color.fromARGB(4, 0, 0, 0),
        automaticallyImplyLeading: false,
        title: const Text('Teste', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            iconSize: 40,
            onPressed: () {
              setState(() {
                isDetailTapped = !isDetailTapped;
              });

              //userDetailDialog(context, 'Teste', 'Teste');
              //LoginApi.logout(context);
            },
            icon: Icon(
              Icons.account_circle,
              color: secondaryColor,
            ),
          )
        ],
        // hide/show this when isDetailTapped is true/false
        bottom: isDetailTapped ? PreferredSize(
          preferredSize: Size.fromHeight(160.0),
          child: Container(
            height: 160.0,
            child: UserDetail(),
          ),
        ) : null,

        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        iconSize: 28,
        items: const <BottomNavigationBarItem>[
          /*BottomNavigationBarItem(
            activeIcon: Icon(Icons.emoji_events_sharp),
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Conquistas',
          ),*/
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
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
