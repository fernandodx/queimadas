import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queimadas/eventbus/main_event_bus.dart';
import 'package:queimadas/pages/api/firebase_service.dart';
import 'package:queimadas/pages/api/firebase_storage_service.dart';
import 'package:queimadas/response_api.dart';
import 'package:queimadas/utils/alert_bottom_sheet.dart';
import 'package:queimadas/utils/nav.dart';

import '../home_page.dart';

class CadastroBloc {
  FirebaseUser user;

  CadastroBloc.withUser(this.user);

  CadastroBloc();

  String urlPhotoUser =
      "http://cdn2.iconfinder.com/data/icons/online-shop-outline/100/objects-07-512.png";

  final streamController = StreamController<Widget>();

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextControlller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final focusSenha = FocusNode();

  Stream<Widget> get stremPicture => streamController.stream;

  void fetch() async {
    if (user != null) {
      urlPhotoUser = user.photoUrl;
      nameTextController.text = user.displayName;
      emailTextController.text = user.email;
    }

    final imgDefault = CircleAvatar(
      radius: 70,
      backgroundImage: NetworkImage(urlPhotoUser),
    );

    streamController.add(imgDefault);
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

  onClickSaveOrUpdate(BuildContext context) async {
    if (!formKey.currentState.validate()) {
      return;
    }

    var nome = nameTextController.text;
    var email = emailTextController.text;
    var pass = passwordTextControlller.text;

    ResponseApi<FirebaseUser> response;

    if (user != null) {
      response = await FirebaseService()
          .updateUser(context, name: nome, urlPhoto: urlPhotoUser);
    } else {
      response = await FirebaseService().createUserWithEmailAndPassword(context,
          email, pass,
          name: nome, urlPhoto: urlPhotoUser);
    }

    if (response.ok) {
      push(context, HomePage(), isReplace: true);
    } else {
      print('EXIBIR MSG ERRO');
      alertBottomSheet(context, msg: response.msg);
    }
  }

  onAddImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    urlPhotoUser =
        await FirebaseStorageService().uploadFile(image, id: "user_photo");

    var circleImage = CircleAvatar(
      radius: 70,
      backgroundImage: Image.file(image).image,
    );
    streamController.add(circleImage);
  }
}
