import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:queimadas/eventbus/main_event_bus.dart';
import 'package:queimadas/model/sample_dropdawn.dart';
import 'package:queimadas/pages/login/login_bloc.dart';
import 'package:queimadas/widgets/app_button_default.dart';
import 'package:queimadas/widgets/app_dropdaw.dart';
import 'package:queimadas/widgets/app_text_default.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _bloc.formKey,
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              AppTextDefault(
                name: "E-mail",
                controller: _bloc.emailTextController,
                validator: _bloc.validatorEmail,
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                nextFocus: _bloc.focusSenha,
              ),
              SizedBox(height: 15),
              AppTextDefault(
                name: "Senha",
                controller: _bloc.senhaTextControlller,
                validator: _bloc.validatorSenha,
                inputType: TextInputType.number,
                inputAction: TextInputAction.done,
                focus: _bloc.focusSenha,
                isPassword: true,
              ),
              SizedBox(height: 15),
              AppButtonDefault(
                label: "Entrar",
                onPressed: () => _bloc.onClickLogin(context),
              ),
              GoogleSignInButton(
                onPressed: () => _bloc.onClickLoginGoogle(context),
                borderRadius: 4.0,
                text: "Login com Google",
              ),
              SizedBox(
                height: 20,
              ),
              AppButtonDefault(
                label: "Não tenho cadastro",
                decoration: TextDecoration.underline,
                onPressed: () => _bloc.initSignIn(context),
                type: TypeButton.FLAT,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
