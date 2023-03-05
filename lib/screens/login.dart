import 'package:app/core/api/login-service.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

import '../components/alert.dart';
import '../components/form-field-text.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: body(context, formKey, emailController, passwordController),
      backgroundColor: fifthColor,
    );
  }

  body(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 50, left: 50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Login'),
                    FormFieldText(
                      controller: emailController,
                      placeholder: 'E-mail',
                      icon: const Icon(Icons.email_outlined),
                      inputType: TextInputType.emailAddress,
                      isPassword: false,
                      validator: (value) => emailValidator(value!),
                    ),
                    FormFieldText(
                      controller: passwordController,
                      placeholder: 'Senha',
                      icon: const Icon(Icons.lock_outline),
                      inputType: TextInputType.text,
                      isPassword: true,
                      validator: (value) => passValidator(value!),
                    ),
                    SizedBox(
                      height: 60,
                      width: 130,
                      child: TextButton(
                        child: const Text(
                          "Entrar",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          _clickButton(context, formKey, emailController,
                              passwordController);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? emailValidator(String text) {
    if (text.isEmpty) {
      return "Digite seu e-mail";
    }
    return null;
  }

  String? passValidator(String text) {
    if (text.isEmpty) {
      return "Digite sua senha";
    }
    return null;
  }

  _clickButton(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    bool? formOk = formKey.currentState?.validate();
    if (!formOk!) {
      return;
    }

    String email = emailController.text;
    String password = passwordController.text;

    var authorization = await LoginApi.login(email, password);

    if (authorization != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      alert(context, "Ocorreu um erro",
          "Não foi possível iniciar esta sessão pois o login é inválido.");
    }
  }
}
