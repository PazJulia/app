import 'package:app/screens/pratica.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class ExplicacaoSlides extends StatefulWidget {
  const ExplicacaoSlides({super.key});

  @override
  _ExplicacaoSlidesState createState() => _ExplicacaoSlidesState();
}

class _ExplicacaoSlidesState extends State<ExplicacaoSlides> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      ContentConfig(
        title: "ERASER",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/photo_eraser.png",
        backgroundColor: thirdColor,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title: "Bom diaaaa!",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/photo_eraser.png",
        backgroundColor: thirdColor,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title: "OIE",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/photo_eraser.png",
        backgroundColor: thirdColor,
      ),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < listContentConfig.length; i++) {
      ContentConfig currentSlide = listContentConfig[i];
      tabs.add(
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            margin: EdgeInsets.only(bottom: 160, top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    currentSlide.title ?? '',
                    style: TextStyle(color: secondaryColor, fontSize: 25),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  margin: const EdgeInsets.only(
                    top: 15,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    currentSlide.description ?? '',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
        isShowSkipBtn: false,
        backgroundColorAllTabs: thirdColor,
        renderPrevBtn: Text(
          "Voltar",
          style: TextStyle(color: secondaryColor),
        ),
        renderNextBtn: Text(
          "Pr??ximo",
          style: TextStyle(color: secondaryColor),
        ),
        renderDoneBtn: Text(
          "PRATICAR",
          style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
        ),
        doneButtonStyle: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(primaryColor),
        ),
        listCustomTabs: renderListCustomTabs(),
        scrollPhysics: const BouncingScrollPhysics(),
        onDonePress: () => {Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => const Pratica())) });
  }
}
