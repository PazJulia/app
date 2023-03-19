import 'package:app/core/api/login-service.dart';
import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/alert.dart';
import '../components/form-field-text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/logo.svg';
    final Widget logo = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Code Play Logo',
      width: 250,
    );
    return Scaffold(
      body: body(context, logo),
      backgroundColor: fifthColor,
    );
  }

  body(BuildContext context, Widget logo) {
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
                          onPressed: _isLoading
                              ? null
                              : () => onLogin(context, formKey, emailController,
                                  passwordController),
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

  onLogin(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    bool? formOk = formKey.currentState?.validate();
    if (!formOk!) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await LoginApi.login(emailController.text, passwordController.text)
          .then((authorization) {
        Navigator.pushNamed(context, '/home');
        formKey.currentState?.reset();
      }).catchError((error) {
        alert(context, "Ocorreu um erro", "$error");
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
