import 'package:app/components/alert.dart';
import 'package:app/components/form-field-text.dart';
import 'package:app/components/message-display.dart';
import 'package:app/core/domain/usuario/usuario-controller.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/domain/usuario/usuario.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  CriarContaState createState() => CriarContaState();
}

class CriarContaState extends State<CriarConta> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  bool _isLoading = false;
  UsuarioController usuarioController = UsuarioController();

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
            'Criar Conta',
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
                ))
          ]),
      backgroundColor: fifthColor,
      body: body(context, formKey),
    );
  }

  Widget body(context, GlobalKey<FormState> formKey) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(right: 50, left: 50),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: Text('Preencha os campos abaixo para criar sua conta',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: secondaryColor),
                      textAlign: TextAlign.center),
                ),
                Center(
                    child: Column(children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      height: 20,
                    ),
                    FormFieldText(
                      controller: nameController,
                      placeholder: 'Nome',
                      icon: Icon(Icons.account_circle_outlined, color: secondaryColor),
                      inputType: TextInputType.text,
                      isPassword: false,
                      validator: (value) => nameValidator(value!),
                    ),
                    FormFieldText(
                      controller: emailController,
                      placeholder: 'E-mail',
                      icon: Icon(Icons.email_outlined, color: secondaryColor),
                      inputType: TextInputType.emailAddress,
                      isPassword: false,
                      validator: (value) => emailValidator(value!),
                    ),
                    FormFieldText(
                      controller: passController,
                      placeholder: 'Senha',
                      icon: Icon(Icons.lock_outline, color: secondaryColor),
                      inputType: TextInputType.text,
                      isPassword: true,
                      validator: (value) => passwordValidator(value!),
                    ),
                    FormFieldText(
                      controller: confirmPassController,
                      placeholder: 'Confirmação de Senha',
                      icon: Icon(Icons.lock_outline, color: secondaryColor),
                      inputType: TextInputType.text,
                      isPassword: true,
                      validator: (value) => confirmPasswordValidator(value!),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () => {
                                        onSubmit(
                                            context,
                                            formKey,
                                            emailController.text,
                                            passController.text,
                                            confirmPassController.text)
                                      },
                              style: ElevatedButton.styleFrom(
                                shape: const BeveledRectangleBorder(),
                                backgroundColor: secondaryColor,
                                shadowColor: Colors.transparent,
                                disabledBackgroundColor: secondaryColor,
                              ),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          primaryColor),
                                    )
                                  : Text(
                                      'CRIAR CONTA',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                            )))
                  ])
                ]))
              ])),
        ));
  }

  String? nameValidator(String text) {
    if (text.isEmpty) {
      return "Digite seu nome";
    } else if (text.length > 50) {
      return "O nome deve ter no máximo 50 caracteres";
    }
    return null;
  }

  String? emailValidator(String text) {
    if (text.isEmpty) {
      return "Digite seu e-mail";
    } else if (text.length > 50) {
      return "O e-mail deve ter no máximo 50 caracteres";
    } // validate email format with regex
    else if (!RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$')
        .hasMatch(text)) {
      return "Digite um e-mail válido";
    }
    return null;
  }

  String? passwordValidator(String text) {
    if (text.isEmpty) {
      return "Digite sua senha";
    } else if (text.length < 6) {
      return "A senha deve ter no mínimo 6 caracteres";
    } else if (text.length > 20) {
      return "A senha deve ter no máximo 20 caracteres";
    }
    return null;
  }

  String? confirmPasswordValidator(String text) {
    if (text.isEmpty) {
      return "Confirme sua senha";
    } else if (text != passController.text) {
      return "As senhas devem ser iguais";
    }
    return null;
  }

  onSubmit(context, GlobalKey<FormState> formKey, String email, String password,
      String confirmPassword) async {
    bool? formOk = formKey.currentState?.validate();
    if (!formOk!) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      Usuario usuario = Usuario(
          nome: nameController.text,
          email: emailController.text,
          senha: passController.text);
      await usuarioController.create(usuario).then((user) {
        Navigator.pop(context);
        MessageDisplay.show(
            'Usuário criado com sucesso! Insira suas credenciais para continuar', context,
            color: eighthColor);
      });
    } catch (error) {
      alert(context, "Ocorreu um erro", "$error");
    } finally {
      setState(() {
        _isLoading = false;
        formKey.currentState?.reset();
      });
    }
  }
}
