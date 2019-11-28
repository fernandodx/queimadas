import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queimadas/pages/api/firebase_service.dart';
import 'package:queimadas/pages/api/firebase_storage_service.dart';
import 'package:queimadas/response_api.dart';
import 'package:queimadas/utils/alert_bottom_sheet.dart';
import 'package:queimadas/utils/nav.dart';
import 'package:queimadas/utils/prefs.dart';

import '../home_page.dart';

class CadastroBloc {

  final _streamController = StreamController<Widget>();

  final nomeTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final senhaTextControlller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final focusSenha = FocusNode();

  Stream<Widget> get stremPicture => _streamController.stream;

  void fetch() async {
    final imgDefault = CachedNetworkImage(
      imageUrl:
      "https://cdn2.iconfinder.com/data/icons/online-shop-outline/100/objects-07-512.png",
    );

//    await Future.delayed(Duration(seconds: 4));

    _streamController.add(imgDefault);
  }


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

  onAddImage() async {

   File image = await ImagePicker.pickImage(source: ImageSource.gallery);

   _streamController.add(Image.file(image));

   FirebaseStorageService().uploadFile(image, id: "user_photo");

  }





}