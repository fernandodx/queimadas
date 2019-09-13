import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            _textField(name: "E-mail"),
            SizedBox(height: 15),
            _textField(name: "Senha", isPassword: true),
            SizedBox(height: 15),
            _createButtonDefault("Entrar"),
          ],
        ),
      ),
    );
  }

  RaisedButton _createButtonDefault(String label) {
    return RaisedButton(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            color: Colors.redAccent,
            textColor: Colors.white,
            onPressed: () {},
          );
  }

  TextFormField _textField(
      {@required String name, String hint = "", bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: name,
        hintText: hint,
      ),
    );
  }
}
