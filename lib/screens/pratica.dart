import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
          center: const Text(
            "1/2",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
            color: secondaryColor,
            icon: const Icon(
              Icons.cancel,
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: fifthColor,
        child: Column(
          children: [
            const Expanded(
              child: Text('HELLOOOOOOO'),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const BeveledRectangleBorder(),
                  backgroundColor: thirdColor,
                  shadowColor: Colors.transparent,
                  disabledBackgroundColor: primaryColor
                ),
                child: const Text(
                  'VERIFICAR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
