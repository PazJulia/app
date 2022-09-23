import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        actions: const <Widget>[

        ],
        shadowColor: const Color.fromARGB(4, 0, 0, 0),
        backgroundColor: Colors.white,
        title: const Text('TESTE', style: TextStyle(color: Colors.black),),
      ),
      body: _body(context),
      bottomNavigationBar: BottomNavyBar(),
    );
  }

  _body(BuildContext context) {
    return const Padding(padding: EdgeInsets.only(right: 50.0, left: 50.0),);
  }
}

class BottomNavyBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavyBarState();
  }
}

class BottomNavyBarState extends State<BottomNavyBar> {

  int selectedIndex = 1;

  List<NavigationItem> items = [
    NavigationItem(const Icon(Icons.emoji_events_rounded), const Text('Conquistas')),
    NavigationItem(const Icon(Icons.home_rounded), const Text('Início')),
    NavigationItem(const Icon(Icons.leaderboard_rounded), const Text('Classificação')),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected){
    return Container(
      height: 50,
      width: isSelected ? 125 : 50,
      decoration: isSelected ? const BoxDecoration(
        color: Color.fromARGB(255, 133, 145, 255),
        borderRadius: BorderRadius.all(Radius.circular(30))
      ) : null,
      child: Row(
        children: <Widget>[
          IconTheme(
            data: const IconThemeData(
              size: 26,
            ),
            child: item.icon,
          ), Padding(
            padding: const EdgeInsets.only(left: 3),
            child: isSelected ? item.title : Container(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 56,
      padding: const EdgeInsets.only(top: 4, right: 30, bottom: 4, left: 30),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = itemIndex;
              });
            },
            child: _buildItem(item, selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;

  NavigationItem(this.icon, this.title);
}
