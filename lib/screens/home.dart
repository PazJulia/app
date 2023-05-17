import 'package:app/components/alert.dart';
import 'package:app/components/user-detail.dart';
import 'package:app/core/api/login-service.dart';
import 'package:app/core/domain/matricula/matricula-controller.dart';
import 'package:app/core/domain/matricula/matricula.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/assiduidade.dart';
import '../shared/values/colors.dart';
import 'formacao.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MatriculaController matriculaController = MatriculaController();
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

  Matricula? _matricula;

  @override
  void initState() {
    super.initState();
    fetchMatricula();
  }

  Future<void> fetchMatricula() async {
    try {
      final matricula = await matriculaController.getMatricula();
      setState(() {
        _matricula = matricula;
      });
    } catch (error) {
      alert(context, 'Erro ao carregar Dados', error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginApi();
    return Scaffold(
      backgroundColor: fifthColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: const Color.fromARGB(4, 0, 0, 0),
        automaticallyImplyLeading: false,
        title: _matricula == null
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _matricula!.linguagem.nome,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Assiduidade(_matricula!)
                ],
              ),
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
        bottom: isDetailTapped
            ? PreferredSize(
                preferredSize: const Size.fromHeight(160.0),
                child: SizedBox(
                  height: 160.0,
                  child: UserDetail(_matricula!),
                ),
              )
            : null,

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
