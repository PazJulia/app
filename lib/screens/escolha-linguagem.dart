import 'package:app/core/domain/linguagem/linguagem-controller.dart';
import 'package:app/core/domain/linguagem/linguagem.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EscolhaLinguagem extends StatelessWidget {
  const EscolhaLinguagem({super.key});

  @override
  Widget build(BuildContext context) {
    LinguagemController linguagemController = LinguagemController();

    return Scaffold(
      backgroundColor: fifthColor,
      body: Center(
        child: FutureBuilder<List<Linguagem>>(
          future: linguagemController.listLinguagensByUsuario(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return linguagens(snapshot.data!, context);
            }
          },
        ),
      ),
    );
  }

  Widget linguagens(List<Linguagem> lista, context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Center(
                child: Text('Para continuar, escolha uma linguagem',
                    style: TextStyle(fontSize: 16))),
          ),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 10 / 4,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              lista.length,
              (index) {
                final item = lista[index];
                return TextButton(
                  onPressed: () {
                    guardarLinguagemRedirecionar(item, context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        item.nome,
                        style: TextStyle(color: secondaryColor),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  guardarLinguagemRedirecionar(Linguagem linguagem, context) async {
    // store linguagem on sharedPreferences

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("language", linguagem.id);
    Navigator.pushNamed(context, '/home');
  }
}
