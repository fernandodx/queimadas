import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/pages/api/firebase_service.dart';
import 'package:queimadas/pages/cadastro/cadastro_bloc.dart';
import 'package:queimadas/widgets/app_button_default.dart';
import 'package:queimadas/widgets/app_text_default.dart';

class RegisterOrUpdate extends StatefulWidget {

  CadastroBloc bloc;

  RegisterOrUpdate.withUser(FirebaseUser user){
    bloc = CadastroBloc.withUser(user);
  }

  RegisterOrUpdate(){
    bloc = CadastroBloc();
  }

  @override
  _RegisterOrUpdateState createState() => _RegisterOrUpdateState(bloc);
}

class _RegisterOrUpdateState extends State<RegisterOrUpdate> {

  CadastroBloc _bloc;

  _RegisterOrUpdateState(this._bloc);

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
              checkPhotoUser(),
              AppTextDefault(
                name: "Nome",
                controller: _bloc.nameTextController,
                validator: _bloc.validatorCampoObrigatorio,
                inputType: TextInputType.text,
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 15),
              Visibility(
                visible: _isInVisibleForEdit(),
                child: AppTextDefault(
                  name: "E-mail",
                  controller: _bloc.emailTextController,
                  validator: _bloc.validatorCampoObrigatorio,
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  nextFocus: _bloc.focusSenha,
                ),
              ),
              SizedBox(height: 15),
              Visibility(
                visible: _isInVisibleForEdit(),
                child: AppTextDefault(
                  name: "Senha",
                  controller: _bloc.passwordTextControlller,
                  validator: _bloc.validatorSenha,
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  focus: _bloc.focusSenha,
                  isPassword: true,
                ),
              ),
              SizedBox(height: 15),
              getButtonSaveOrUpdate(context),
            ],
          ),
        ),
      ),
    );
  }

  AppButtonDefault getButtonSaveOrUpdate(BuildContext context) {

    String label = "Atualizar";

    if(_isInVisibleForEdit()){
      label = "Cadastrar";
    }

    return AppButtonDefault(
              label: label,
              onPressed: () => _bloc.onClickSaveOrUpdate(context),
            );
  }

  bool _isInVisibleForEdit() => fireBaseUserUid == null;

  Widget checkPhotoUser() {
    if(_isInVisibleForEdit()){
      return SizedBox(height: 15);
    }
    return Column(children: <Widget>[
      createStreamBuilderPhotoUser(),
      SizedBox(height: 15),
    ],);
  }


  StreamBuilder<Widget> createStreamBuilderPhotoUser() {

    return StreamBuilder<Widget>(
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
            );
  }

}

