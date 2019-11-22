import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/pages/api/firebase_service.dart';
import 'package:queimadas/response_api.dart';
import 'package:queimadas/utils/nav.dart';
import 'package:queimadas/utils/prefs.dart';

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

  saveSharedPrefs(FirebaseUser user) {
    Prefs.putString("USER_NAME", user.displayName);
    Prefs.putString("USER_EMAIL", user.email);
    Prefs.putString("USER_URL_PHOTO", user.photoUrl);
  }

  Future<String> getNameUser() async {
    return Prefs.getString("USER_NAME");
  }
  Future<String> getUserEmail() async {
    return Prefs.getString("USER_EMAIL");
  }
  Future<String> getUserUrlPhoto() async {
    return Prefs.getString("USER_URL_PHOTO");
  }

  onClickLogin(BuildContext context) async {
//    if (!formKey.currentState.validate()) {
//      return;
//    }
//
//    var email = emailTextController.text;
//    var senha = senhaTextControlller.text;
//
//    print("E-mail: $email senha: $senha");
//
//    push(context, HomePage(), isReplace: true);

      ResponseApi<FirebaseUser> response = await FirebaseService().loginWithGoogle();

      if(response.ok){
        saveSharedPrefs(response.result);
        push(context, HomePage(), isReplace: true);
      }else{
        print(response.msg);
      }

  }



}