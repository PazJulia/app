import 'dart:convert';

import 'package:flutter/material.dart';

import '../shared/values/colors.dart';

class AtividadeEscolhaCodigo extends StatefulWidget {
  const AtividadeEscolhaCodigo({super.key});

  @override
  _AtividadeEscolhaCodigoState createState() => _AtividadeEscolhaCodigoState();
}

class _AtividadeEscolhaCodigoState extends State<AtividadeEscolhaCodigo> {
  final codigosOriginais = ['"', '"', ' = ', '(', ')', 'string python', 'x'];
  late List<bool> estadoBotoes =
      codigosOriginais.map((codigo) => true).toList();
  var codigoResposta = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      codigoResposta.join(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        estadoBotoes =
                            codigosOriginais.map((codigo) => true).toList();
                        codigoResposta = [];
                      });
                    },
                    color: secondaryColor,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                codigosOriginais.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(7),
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: (estadoBotoes[index] == false)
                            ? null
                            : () {
                                setState(() {
                                  estadoBotoes[index] = false;
                                  codigoResposta.add(codigosOriginais[index]);
                                });
                              },
                        style: ButtonStyle(
                          backgroundColor: estadoBotoes[index] == true
                              ? MaterialStateProperty.all<Color>(secondaryColor)
                              : MaterialStateProperty.all<Color>(fifthColor),
                        ),
                        child: Text(
                          codigosOriginais[index],
                          style: TextStyle(
                              color: estadoBotoes[index] == true
                                  ? primaryColor
                                  : Colors.transparent),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
