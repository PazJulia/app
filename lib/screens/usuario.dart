import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsuarioWidget extends StatelessWidget {
  const UsuarioWidget({Key? key}) : super(key: key);

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              size: 100,
              Icons.account_circle,
              color: fourthColor,
            ),
            Text('Nome'),
            Text('Email'),
          ],
        ),
      ),
    );
  }
}
