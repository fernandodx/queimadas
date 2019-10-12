import 'package:flutter/material.dart';
import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/pages/detalheFocus/detail_focus_bloc.dart';
import 'package:queimadas/utils/text_util.dart';

class DetalheFocus extends StatefulWidget {

  FocusFire focus;
  DetalheFocus(this.focus);

  @override
  _DetalheFocusState createState() => _DetalheFocusState();
}

class _DetalheFocusState extends State<DetalheFocus> {

  final _blocText = DetailFocusBloc();

  @override
  void initState() {
    super.initState();

    _blocText.fetch();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.focus.country),
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
              child: TextUtil.textDefault("Quantidade de Focus: ${widget.focus.count}"),
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
