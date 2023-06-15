import 'package:app/shared/functions/convert-color.dart';
import 'package:app/shared/functions/retornar-explicacao-texto-codigo-formatada.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:selectable_code_view/selectable_code_view.dart';

import '../core/domain/licao/licao.dart';

class ExplicacaoSlides extends StatefulWidget {
  const ExplicacaoSlides(this.licao, this.cor, {super.key});

  final Licao? licao;
  final String cor;

  @override
  ExplicacaoSlidesState createState() => ExplicacaoSlidesState();
}

class ExplicacaoSlidesState extends State<ExplicacaoSlides> {
  int explicacaoIndex = 0;
  String explicacaoAtual = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: convertToColor(widget.cor),
      child: Column(
        children: [
          Expanded(child: renderExplicacao()),
          Padding(padding: const EdgeInsets.all(10), child: renderButtons())
        ],
      ),
    );
  }

  renderExplicacao() {
    if (widget.licao == null) {
      return const Text('Não foi possível encontrar a lição');
    } else {
      Set<Map<String, dynamic>> elements =
          retornarExplicacaoTextoCodigoFormatada(
              widget.licao!.explicacao[explicacaoIndex]);
      return Center(
          child: SingleChildScrollView(
              child: Column(
        children: elements.map<Widget>((e) {
          return e['isCode']
              ? code(e['texto'])
              : Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Text(
                    e['texto'].toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                );
        }).toList(),
      )));
    }
  }

  Widget code(String codigo) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SelectableCodeView(
        code: codigo,
        language: Language.JAVA,
        languageTheme: LanguageTheme.gravityDark(),
        fontSize: 14,
        withZoom: false,
        withLinesCount: false,
        expanded: false,
      ),
    );
  }

  renderButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Visibility(
          visible: explicacaoIndex > 0,
          child: renderButton(Icons.arrow_back_rounded, () {
            setState(() {
              explicacaoAtual = widget.licao!.explicacao[explicacaoIndex];
              explicacaoIndex--;
            });
          })),
      if (widget.licao!.explicacao.length - 1 == explicacaoIndex)
        renderButton(
            Icons.check_rounded,
            () => {
                  Navigator.pushNamed(context, '/pratica',
                      arguments: widget.licao),
                }),
      if (explicacaoIndex < widget.licao!.explicacao.length - 1)
        renderButton(Icons.arrow_forward_rounded, () {
          setState(
            () {
              explicacaoAtual = widget.licao!.explicacao[explicacaoIndex];
              explicacaoIndex++;
            },
          );
        })
    ]);
  }

  renderButton(IconData iconData, Function onPressed,
      {Color color = Colors.black}) {
    return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            )),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Icon(iconData, color: color, size: 27, weight: 20),
        ));
  }

  isLastItem() {
    return explicacaoIndex == widget.licao!.explicacao.length - 1;
  }
}
