import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/pages/cadastro/cadastro_bloc.dart';
import 'package:queimadas/widgets/app_button_default.dart';
import 'package:queimadas/widgets/app_text_default.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _bloc = CadastroBloc();

  @override
  void initState() {
    super.initState();

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Novo usuário",
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
              Column(
                children: <Widget>[
                  StreamBuilder<Widget>(
                    stream: _bloc.stremPicture,
                    builder: (context, snapshot){

                      if(snapshot.hasData){

                        return InkWell(
                          child: snapshot.data,
                          onTap: () => _bloc.onAddImage(),
                        );
                      }

                      return CircularProgressIndicator();

                    },
                  )
                ],
              ),
              SizedBox(height: 15),
              AppTextDefault(
                name: "Nome",
                controller: _bloc.nomeTextController,
                validator: _bloc.validatorCampoObrigatorio,
                inputType: TextInputType.text,
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 15),
              AppTextDefault(
                name: "E-mail",
                controller: _bloc.emailTextController,
                validator: _bloc.validatorCampoObrigatorio,
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
                label: "Cadastrar",
                onPressed: () => _bloc.onClickCadastrar(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

