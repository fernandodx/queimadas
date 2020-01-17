import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:queimadas/pages/login/login_bloc.dart';
import 'package:queimadas/pages/progress_bloc.dart';
import 'package:queimadas/widgets/app_button_default.dart';
import 'package:queimadas/widgets/app_text_default.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
//  final _bloc = BlocProvider.getBloc<LoginBloc>();
    final _bloc = LoginBloc();

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
        key: _bloc.formKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.green[100]],
                  begin: FractionalOffset.center,
                  end: FractionalOffset.bottomCenter)),
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
                  onSaved: (value) => print(value),
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
                  onSaved: (value) => print(value),
                ),
                SizedBox(height: 15),
                StreamBuilder<bool>(
                  stream: _bloc.progress.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    return AppButtonDefault(
                      label: "Entrar",
                      isShowProgress: snapshot.data,
                      onPressed: (){
                        _bloc.onClickLogin(context);
                      },
                    );
                  }
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
                Container(
                  width: 130,
                  height: 130,
                  child: FlareActor(
                    "assets/animations/maps.flr",
                    shouldClip: true,
                    animation: "anim",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
