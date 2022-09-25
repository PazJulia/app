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
  late Widget _showPage;

  List<NavigationItem> items = [
    NavigationItem(const Icon(Icons.emoji_events_outlined), const Text('Conquistas', style: TextStyle(fontWeight: FontWeight.bold),)),
    NavigationItem(const Icon(Icons.school_outlined), const Text('Prática', style: TextStyle(fontWeight: FontWeight.bold),)),
    NavigationItem(const Icon(Icons.leaderboard_outlined), const Text('Divisão', style: TextStyle(fontWeight: FontWeight.bold),)),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected){
    return AnimatedContainer(
      height: 50,
      width: isSelected ? 135 : 50,
      padding: isSelected ?
      const EdgeInsets.only(left: 1, right: 2) : null,
      decoration: isSelected ? const BoxDecoration(
        color: Color.fromARGB(255, 133, 182, 255),
        borderRadius: BorderRadius.all(Radius.circular(30))
      ) : null,
      duration: const Duration(milliseconds: 300),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    IconTheme(
                      data: const IconThemeData(
                        color: Colors.black,
                        size: 30,
                      ),
                      child: item.icon,
                    ), Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: isSelected ? DefaultTextStyle(style: const TextStyle(color: Color.fromARGB(
                          255, 235, 245, 255)), child: item.title) : Container(),
                    )
                  ],),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 60,
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
                _showPage = _choosePage(itemIndex);
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

Widget _choosePage(int index){
  switch (index) {
    case 0:
      return Container(color: Colors.blueAccent,);

    case 1:
      return Container(color: Colors.redAccent,);

    case 2:
      return Container(color: Colors.yellow,);
  }
}
