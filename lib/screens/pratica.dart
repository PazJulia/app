import 'package:flutter/material.dart';

import '../components/stars-rating.dart';
import '../shared/values/colors.dart';

class Pratica extends StatelessWidget {
  const Pratica({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Barra de progresso vai aqui",
              style: TextStyle(color: primaryColor),
            ),
          ],
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
            icon: const Icon(
              Icons.cancel,
            ),
          )
        ],
      ),
      body: Container(height: double.infinity, width: double.infinity, color: Colors.red,),
    );
  }

}