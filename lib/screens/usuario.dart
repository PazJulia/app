import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsuarioWidget extends StatelessWidget {
  const UsuarioWidget({Key? key}) : super(key: key);

  static TextStyle labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static TextStyle userInfoStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: fifthColor),
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: fifthColor,
        title: Text(
          'Configurações do Usuário',
          style: TextStyle(color: secondaryColor),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(
              Icons.cancel,
            ),
          )
        ],
      ),
      backgroundColor: fifthColor,
      body: usuario(context),
    );
  }

  Widget usuario(context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                      color: fourthColor,
                    ),
                  ),
                  rowTextsButton(context, 'Nome', 'Nome do usuário', () {}),
                  Container(
                    height: 20,
                  ),
                  rowTextsButton(context, 'E-mail', 'E-mail do usuário', () {}),
                  Container(
                    height: 20,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Alterar Minha Senha',
                      style: labelStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowTextsButton(context, label, info, onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nome',
          style: labelStyle,
        ),
        Row(
          children: [
            Text(
              'Nome do usuário',
              style: userInfoStyle,
            ),
            TextButton(
              onPressed: () {
                onPressed;
              },
              child: Icon(Icons.edit, color: fourthColor),
            ),
          ],
        ),
      ],
    );
  }
}
