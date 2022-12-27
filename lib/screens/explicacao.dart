import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';

class Explicacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.black),
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Título da explicação",
                style: TextStyle(color: Colors.white),
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
        ),
        backgroundColor: Colors.black,
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
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      DotsIndicator(
                        dotsCount: 3,
                        position: 0,
                        decorator: DotsDecorator(
                          activeColor: Colors.black,
                          color: Colors.black12,
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: thirdColor,
                fixedSize: const Size(double.maxFinite, 60),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            onPressed: () {},
            child: const Text(
              'Praticar',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      )),
    );
  }
}
