import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
        backgroundColor: fifthColor,
        title: LinearPercentIndicator(
          lineHeight: 30,
          percent: 0.5,
          center: const Text("1/2", style: TextStyle(fontWeight: FontWeight.bold),),
          barRadius: const Radius.circular(16),
          progressColor: fourthColor,
          backgroundColor: Colors.grey[300],
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