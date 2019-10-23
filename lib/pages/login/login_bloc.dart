import 'package:flutter/material.dart';
import 'package:queimadas/utils/nav.dart';

import '../home_page.dart';

class LoginBloc {

  final emailTextController = TextEditingController();

  final senhaTextControlller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final focusSenha = FocusNode();

  String validatorEmail(String value) {
    if (value.isEmpty) {
      return "E-mail é obrigatório";
    }
    return null;
  }

  String validatorSenha(String value) {
    if (value.isEmpty) {
      return "Senha é obrigatório";
    }
    if (value.length < 8) {
      return "Sua senha tem que ter no minímo 8 dígitos";
    }
    return null;
  }

  onClickLogin(BuildContext context) {
    if (!formKey.currentState.validate()) {
      return;
    }

    var email = emailTextController.text;
    var senha = senhaTextControlller.text;

    print("E-mail: $email senha: $senha");

    push(context, HomePage(), isReplace: true);
  }


}