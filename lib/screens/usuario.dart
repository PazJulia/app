import 'package:app/components/alert.dart';
import 'package:app/components/message-display.dart';
import 'package:app/core/api/login-service.dart';
import 'package:app/core/domain/usuario/usuario-controller.dart';
import 'package:app/core/domain/usuario/usuario.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/form-field-text.dart';

class UsuarioWidget extends StatefulWidget {
  const UsuarioWidget(this.usuario, {Key? key}) : super(key: key);
  final Usuario usuario;

  @override
  UsuarioState createState() => UsuarioState();
}

class UsuarioState extends State<UsuarioWidget> {
  LoginApi loginApi = LoginApi();
  static TextStyle labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static TextStyle userInfoStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w300);

  bool editUser = false;
  bool editEmail = false;
  final formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  bool isLoading = false;
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
                ))
          ]),
      backgroundColor: fifthColor,
      body: body(context, formKey),
    );
  }

  Widget body(context, GlobalKey<FormState> formKey) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Center(
                        child: Icon(
                      Icons.account_circle,
                      size: 100,
                      color: fourthColor,
                    )),
                    if (editUser)
                      form(userController, 'Nome', formKey, isName: true)
                    else
                      rowTextsButton(context, 'Nome', widget.usuario.nome, () {
                        setState(() {
                          setFormState(true, false, formKey);
                        });
                      }),
                    Container(height: 30),
                    if (editEmail)
                      form(emailController, 'E-mail', formKey, isName: false)
                    else
                      rowTextsButton(context, 'E-mail', widget.usuario.email,
                          () {
                        setState(() {
                          setFormState(false, true, formKey);
                        });
                      }),
                    Container(height: 20),
                    button(context, 'Alterar Minha Senha', primaryColor, () {
                      Navigator.pushNamed(context, '/alterar-senha');
                    })
                  ]))
            ])));
  }

  Widget form(TextEditingController controller, String label,
      GlobalKey<FormState> formKey,
      {required bool isName}) {
    return Form(
        key: formKey,
        child: Column(children: [
          FormFieldText(
              placeholder: label,
              icon: Icon(Icons.edit, color: fourthColor),
              inputType: TextInputType.text,
              isPassword: false,
              validator: (value) =>
                  isName ? userValidator(value!) : emailValidator(value!),
              controller: controller),
          Container(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            button(context, 'Cancelar', Colors.transparent, () {
              setState(() {
                setFormState(false, false, formKey);
              });
            }),
            Container(width: 20),
            button(context, 'Salvar', primaryColor, () {
              isLoading ? null : onSave(isName, formKey, controller);
            })
          ]),
          Container(height: 40)
        ]));
  }

  Widget button(context, label, bgColor, Function onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(10), backgroundColor: bgColor),
      onPressed: () {
        onPressed();
      },
      child: Text(label, style: labelStyle),
    );
  }

  onSave(bool isName, GlobalKey<FormState> formKey,
      TextEditingController controller) async {
    LoginApi();
    bool? formOk = formKey.currentState?.validate();
    if (!formOk!) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    if (isName) {
      await _patchValue(() => usuarioController.patchNome(controller.text));
    } else {
      await _patchValue(() => usuarioController.patchEmail(controller.text));
    }
  }

  Future<void> _patchValue(Function patchFunction) async {
    try {
      await patchFunction().then((user) {
        LoginApi.logout(context);
        MessageDisplay.show(
            'Usuário atualizado com sucesso. Por favor, insira suas credenciais novamente', context,
            color: eighthColor);
      });
    } catch (error) {
      alert(context, "Ocorreu um erro", "$error");
    } finally {
      setState(() {
        isLoading = false;
        setFormState(false, false, formKey);
      });
    }
  }

  String? userValidator(String text) {
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

  setFormState(bool userState, bool emailState, GlobalKey<FormState> formKey) {
    editUser = userState;
    editEmail = emailState;
    formKey.currentState?.reset();
  }

  Widget rowTextsButton(context, label, info, Function onPressed) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: labelStyle),
      Row(children: [
        Text(info, style: userInfoStyle),
        TextButton(
          onPressed: () {
            onPressed();
          },
          child: Icon(Icons.edit, color: fourthColor),
        )
      ])
    ]);
  }
}
