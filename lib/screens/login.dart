import 'package:app/core/api/login-service.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/alert.dart';
import '../components/form-field-text.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    const String assetName = 'assets/logo.svg';
    final Widget logo = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Code Play Logo',
      width: 250,
    );
    return Scaffold(
      body: body(context, formKey, emailController, passwordController, logo),
      backgroundColor: fifthColor,
    );
  }

  body(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController,
      Widget logo) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 50, left: 50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: logo,
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
                      controller: passwordController,
                      placeholder: 'Senha',
                      icon: Icon(Icons.lock_outline, color: secondaryColor),
                      inputType: TextInputType.text,
                      isPassword: true,
                      validator: (value) => passValidator(value!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _clickButton(context, formKey, emailController,
                                passwordController);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const BeveledRectangleBorder(),
                            backgroundColor: secondaryColor,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: primaryColor,
                          ),
                          child: Text(
                            'ENTRAR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
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
