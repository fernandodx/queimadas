import 'package:flutter/material.dart';

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
        title: Text("Cadastro"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              _textField(
                name: "E-mail",
                controller: emailTextController,
                validator: _validatorEmail,
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                nextFocus: _focusSenha,
              ),
              SizedBox(height: 15),
              _textField(
                  name: "Senha",
                  controller: senhaTextControlller,
                  validator: _validatorSenha,
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  focus: _focusSenha,
                  isPassword: true),
              SizedBox(height: 15),
              _createButtonDefault("Entrar", _onClickLogin),
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton _createButtonDefault(String label, Function onPressed) {
    return RaisedButton(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      color: Colors.redAccent,
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }

  TextFormField _textField({
    @required String name,
    String hint = "",
    bool isPassword = false,
    TextEditingController controller,
    FormFieldValidator<String> validator,
    TextInputType inputType,
    TextInputAction inputAction,
    FocusNode focus,
    FocusNode nextFocus,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      keyboardType: inputType,
      focusNode: focus,
      textInputAction: inputAction,
      onFieldSubmitted: (value) {
        print(value);
        if(nextFocus != null){
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        labelText: name,
        hintText: hint,
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
