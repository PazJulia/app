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

  var codigoResposta = [];

  @override
  Widget build(BuildContext context) {
    var comando = List.from(codigosOriginais);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: 
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
                        comando = [];
                        comando = List.from(codigosOriginais);
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
              children: [
                for (var i in comando)
                  Padding(
                    padding: const EdgeInsets.all(7),
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            codigoResposta.add(i);
                            comando.remove(i);
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(secondaryColor),
                        ),
                        child: Text(
                          i,
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
