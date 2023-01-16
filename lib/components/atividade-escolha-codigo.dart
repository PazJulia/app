import 'package:flutter/material.dart';

import '../shared/values/colors.dart';

class AtividadeEscolhaCodigo extends StatefulWidget {
  const AtividadeEscolhaCodigo({super.key});

  @override
  _AtividadeEscolhaCodigoState createState() => _AtividadeEscolhaCodigoState();
}

class _AtividadeEscolhaCodigoState extends State<AtividadeEscolhaCodigo> {
  var clickedButtonPosition = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    List<int> _items = List.generate(6, (i) => i);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Expanded(
        child: Column(
          children: [
            Container(
              height: 150,
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: sixthColor,
                  width: 2.0,
                ),
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (var i in _items)
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(secondaryColor)),
                      child: Text(
                        'Item blaa bla $i',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
