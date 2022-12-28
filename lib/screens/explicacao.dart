import 'package:app/screens/explicacao-slides.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Explicacao extends StatelessWidget {
  const Explicacao({super.key});

  static const type = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: secondaryColor),
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Título da explicação",
              style: TextStyle(color: primaryColor),
            ),
            Row(
              children: [
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.yellow,
                ),
              ],
            )
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
      body: ExplicacaoSlides(),
    );
  }
}
