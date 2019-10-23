import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/pages/home_page.dart';
import 'package:queimadas/utils/nav.dart';
import 'package:queimadas/widgets/app_button_default.dart';
import 'package:queimadas/widgets/app_text_default.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailTextController = TextEditingController();

  final senhaTextControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
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
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              AppTextDefault(
                name: "E-mail",
                controller: emailTextController,
                validator: _validatorEmail,
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                nextFocus: _focusSenha,
              ),
              SizedBox(height: 15),
              AppTextDefault(
                name: "Senha",
                controller: senhaTextControlller,
                validator: _validatorSenha,
                inputType: TextInputType.number,
                inputAction: TextInputAction.done,
                focus: _focusSenha,
                isPassword: true,
              ),
              SizedBox(height: 15),
              AppButtonDefault(
                label: "Entrar",
                onPressed: _onClickLogin,
              )
            ],
          ),
        ),
      ),
    );
  }

  _onClickLogin() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    var email = emailTextController.text;
    var senha = senhaTextControlller.text;

    print("E-mail: $email senha: $senha");

    push(context, HomePage(), isReplace: true);
  }

  String _validatorEmail(String value) {
    if (value.isEmpty) {
      return "E-mail é obrigatório";
    }
    return null;
  }

  String _validatorSenha(String value) {
    if (value.isEmpty) {
      return "Senha é obrigatório";
    }
    if (value.length < 8) {
      return "Sua senha tem que ter no minímo 8 dígitos";
    }
    return null;
  }
}
