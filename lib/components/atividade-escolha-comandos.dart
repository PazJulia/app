import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

class AtividadeEscolhaComandos extends StatefulWidget {
  const AtividadeEscolhaComandos({super.key});

  @override
  _AtividadeEscolhaComandosState createState() =>
      _AtividadeEscolhaComandosState();
}

class _AtividadeEscolhaComandosState extends State<AtividadeEscolhaComandos> {
  var clickedButtonPosition = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GridView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => SizedBox(
          height: 20,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                clickedButtonPosition[index] = true;
              });
            },
            style: ButtonStyle(
              backgroundColor: clickedButtonPosition[index] == true
                  ? MaterialStateProperty.all<Color>(secondaryColor)
                  : MaterialStateProperty.all<Color>(primaryColor),
            ),
            child:
                Text('Index: $index\nValue: ${clickedButtonPosition[index]}'),
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
