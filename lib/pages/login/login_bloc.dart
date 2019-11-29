import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/pages/api/firebase_service.dart';
import 'package:queimadas/pages/cadastro/cadastro.dart';
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

  saveDateLoginSharedPrefs(DateTime time) {
    Prefs.putInt("LAST_LOGIN", time.millisecondsSinceEpoch);
  }

  Future<String> getDateLastLogin() async {
    final dateTime = await Prefs.getInt("LAST_LOGIN");
    final date = DateTime.fromMicrosecondsSinceEpoch(dateTime);
    return "${date.day}/${date.month}/${date.year}";
  }


  onClickLogin(BuildContext context) async {
      if (!formKey.currentState.validate()) {
        return;
      }

      var email = emailTextController.text;
      var pass = senhaTextControlller.text;

      ResponseApi<FirebaseUser> response = await FirebaseService().loginWithEmailAndPassword(email, pass);

      if(response.ok){
        saveDateLoginSharedPrefs(DateTime.now());
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        FirebaseService().saveUser(user);
        push(context, HomePage(), isReplace: true);
      }else{
        print(response.msg);
      }

  }

  onClickLoginGoogle(BuildContext context) async {

    ResponseApi<FirebaseUser> response = await FirebaseService().loginWithGoogle();

    if(response.ok){
      saveDateLoginSharedPrefs(DateTime.now());
      push(context, HomePage(), isReplace: true);
    }else{
      print(response.msg);
    }

  }

  initSignIn(context) {
    push(context, Cadastro());
  }




}