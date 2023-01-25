import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

class AtividadeEscolhaComandos extends StatefulWidget {
  const AtividadeEscolhaComandos({super.key});

  @override
  _AtividadeEscolhaComandosState createState() =>
      _AtividadeEscolhaComandosState();
}

class _AtividadeEscolhaComandosState extends State<AtividadeEscolhaComandos> {
  var buttonValues = ['a = 3', 'a = \'python\'', 'print(python)', 'a = python'];
  late List<bool> clickedButtonPosition = buttonValues.map((value) => false).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 30, right: 20, bottom: 5, left: 20),
      child: GridView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => SizedBox(
          height: 20,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                clickedButtonPosition = [false, false, false, false];
                clickedButtonPosition[index] = true;
              });
            },
            style: ButtonStyle(
              backgroundColor: clickedButtonPosition[index] == true
                  ? MaterialStateProperty.all<Color>(secondaryColor)
                  : MaterialStateProperty.all<Color>(primaryColor),
            ),
            child: Text(
              buttonValues[index],
              style: TextStyle(
                  color: clickedButtonPosition[index] == true
                      ? primaryColor
                      : secondaryColor),
            ),
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 6 / 2,
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
