import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queimadas/pages/addFocus/add_focus_fire_bloc.dart';
import 'package:queimadas/utils/text_util.dart';
import 'package:queimadas/widgets/app_button_default.dart';
import 'package:queimadas/widgets/app_text_default.dart';

class AddFocusFire extends StatefulWidget {
  @override
  _AddFocusFireState createState() => _AddFocusFireState();
}

class _AddFocusFireState extends State<AddFocusFire> {

  final _bloc = AddFocusFireBloc();

  @override
  void initState() {
    super.initState();

    _bloc.fetch();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextUtil.textTitulo("Adicionar um focus de Queimada"),
      ),
      body: Form(
        key: _bloc.keyForm,
        child: Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              getStreamBuilder(context),
              SizedBox(
                height: 20,
              ),
              AppTextDefault(
                name: "Descrição",
                hint: "Descrição",
                validator: _bloc.validatedFieldDefault,
                controller: _bloc.descricaoController,
                inputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              AppTextDefault(
                name: "Data",
                hint: "Data",
                controller: _bloc.dataController,
                inputType: TextInputType.datetime,
              ),
              SizedBox(
                height: 20,
              ),
              AppButtonDefault(
                label: "Adicionar",
                onPressed: () => _bloc.onPressAdd(),
              )
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<Widget> getStreamBuilder(context) {
    return StreamBuilder(
              stream: _bloc.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return TextUtil.textTitulo("Erro ao carregar a imagem");
                }

                if (snapshot.hasData) {
                  return InkWell(
                    child: snapshot.data,
                    onTap: () => _bloc.addImage(context),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );

              },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
