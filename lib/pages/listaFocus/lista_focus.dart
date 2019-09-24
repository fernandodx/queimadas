import 'package:flutter/material.dart';
import 'package:queimadas/ResponseApi.dart';
import 'package:queimadas/pages/listaFocus/datail_focus.dart';
import 'package:queimadas/pages/listaFocus/lista_focus_api.dart';
import 'package:queimadas/utils/alert.dart';

import '../../Focus.dart';

class ListaFocus extends StatefulWidget {
  @override
  _ListaFocusState createState() => _ListaFocusState();
}

class _ListaFocusState extends State<ListaFocus> {
  List<Focus> listaFocus = List();

  @override
  void initState() {
    super.initState();

    print("INIT");

    loadData();
  }

  void loadData() async {
    ResponseApi<List<Focus>> response = await ListaFocusApi.findFocus();
    if (response.ok) {
      print("LISTA OK");
      listaFocus = response.result;
    }

//    ResponseApi response = await ListaFocusApi.findFocusDetail("Brasil");
//    if(response.ok) {
//      List<DetailFocus> detailFocus = response.result;
//      simpleAlert(context, msg: detailFocus.length.toString());
//    }else{
//      simpleAlert(context, msg: "Não foi possível detalhar os focus");
//    }
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD");
    return ListView.builder(
        itemCount: listaFocus.length,
        itemBuilder: (context, index) {
          Focus focus = listaFocus[index];
          return Row(
            children: <Widget>[
              Image.network("https://www.countryflags.io/br/flat/64.png"),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Text(
                      focus.country,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text("Quantidade de focus de queimadas: ${focus.count}",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
