import 'package:app/shared/values/colors.dart';
import 'package:flutter/material.dart';

class FormFieldText extends StatelessWidget {
  final String placeholder;
  final Icon icon;
  final TextInputType inputType;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const FormFieldText(
      {super.key,
      required this.placeholder,
      required this.icon,
      required this.inputType,
      required this.isPassword,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      obscureText: isPassword,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor)),
          labelText: placeholder,
          prefixIcon: Container(
            transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
            child: icon,
          ),
          labelStyle: TextStyle(color: secondaryColor)),
    );
  }
}
