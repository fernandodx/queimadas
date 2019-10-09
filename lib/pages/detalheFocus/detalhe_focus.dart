import 'package:flutter/material.dart';
import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/utils/text_util.dart';

class DetalheFocus extends StatelessWidget {
  FocusFire focus;

  DetalheFocus(this.focus);

  @override
  Widget build(BuildContext context) {
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
                )
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: TextUtil.textDefault("Quantidade de Focus: ${focus.count}"),
        ),
      ),
    );
  }

  _onClickFavorite() {}

  _onClickShared() {}
}
