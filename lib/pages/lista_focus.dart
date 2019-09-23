import 'package:flutter/material.dart';
import 'package:queimadas/ResponseApi.dart';
import 'package:queimadas/pages/datail_focus.dart';
import 'package:queimadas/pages/lista_focus_api.dart';
import 'package:queimadas/utils/alert.dart';

import '../Focus.dart';

class ListaFocus extends StatefulWidget {
  @override
  _ListaFocusState createState() => _ListaFocusState();
}

class _ListaFocusState extends State<ListaFocus> {

  @override
  void initState() {
    super.initState();

    loadData();

  }

  void loadData() async {
//    List<Focus> lista = await ListaFocusApi.findFocus();
//    print(lista);
    ResponseApi response = await ListaFocusApi.findFocusDetail("Brasil");
    if(response.ok) {
      List<DetailFocus> detailFocus = response.result;
      simpleAlert(context, msg: detailFocus.length.toString());
    }else{
      simpleAlert(context, msg: "Não foi possível detalhar os focus");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
