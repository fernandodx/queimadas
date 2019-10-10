import 'package:flutter/material.dart';
import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/pages/detalheFocus/detail_focus_bloc.dart';
import 'package:queimadas/utils/text_util.dart';

class DetalheFocus extends StatelessWidget {

  final _blocText = DetailFocusBloc();
  FocusFire focus;
  DetalheFocus(this.focus);


  @override
  Widget build(BuildContext context) {

    _blocText.fetch();

    return Scaffold(
      appBar: AppBar(
        title: Text(focus.country),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.favorite,
              ),
              onPressed: _onClickFavorite()),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _onClickShared(),
          ),

          PopupMenuButton<String>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "EDITAR",
                  child: Text("editar"),
                ),
                PopupMenuItem(
                  value: "EXCLUIR",
                  child: Text("Excluir"),
                ),

              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: TextUtil.textDefault("Quantidade de Focus: ${focus.count}"),
            ),
            SizedBox(height: 20),
            StreamBuilder(
                stream: _blocText.strem,
                initialData: "Carregando",
                builder: (context, snapshot) {

                  if(snapshot.hasData){
                    return TextUtil.textDefault(snapshot.data);
                  }
                  if(snapshot.hasError){
                    return TextUtil.textDefault(snapshot.error);
                  }

                  return TextUtil.textTitulo("Carreando...");

            }),
          ],
        ),
      ),
    );
  }

  _onClickFavorite() {}

  _onClickShared() {}
}
