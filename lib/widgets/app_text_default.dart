import 'package:flutter/material.dart';

class AppTextDefault extends StatelessWidget {
  String name;
  String hint;
  bool isPassword;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType inputType;
  TextInputAction inputAction;
  FocusNode focus;
  FocusNode nextFocus;

  AppTextDefault(
      {@required this.name,
      this.hint = "",
      this.isPassword = false,
      this.controller,
      this.validator,
      this.inputType,
      this.inputAction,
      this.focus,
      this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      keyboardType: inputType,
      focusNode: focus,
      textInputAction: inputAction,
      onFieldSubmitted: (value) {
        print(value);
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        labelText: name,
        hintText: hint,
      ),
    );
  }
}
