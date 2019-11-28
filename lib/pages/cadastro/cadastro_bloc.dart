import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/pages/api/firebase_service.dart';
import 'package:queimadas/response_api.dart';
import 'package:queimadas/utils/alert_bottom_sheet.dart';
import 'package:queimadas/utils/nav.dart';
import 'package:queimadas/utils/prefs.dart';

import '../home_page.dart';

class CadastroBloc {

  final nomeTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final senhaTextControlller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final focusSenha = FocusNode();

  String validatorCampoObrigatorio(String value) {
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


  onClickCadastrar(BuildContext context) async {
    if (!formKey.currentState.validate()) {
      return;
    }

    var nome = nomeTextController.text;
    var email = emailTextController.text;
    var pass = senhaTextControlller.text;

    ResponseApi<FirebaseUser> response = await FirebaseService().createUserWithEmailAndPassword(email, pass,
    name: nome);

    if(response.ok){
      push(context, HomePage(), isReplace: true);
    }else{
      print('EXIBIR MSG ERRO');
      alertBottomSheet(context, msg: response.msg);
    }

  }





}