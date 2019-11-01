import 'package:flutter/material.dart';
import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/pages/listaFocus/lista_focus_api.dart';

import '../response_api.dart';

class ListaFocusModel  extends ChangeNotifier{

  List<FocusFire> listaFocusFire = null;

  Future<ResponseApi> atualizarListaFocusFire() async {
    ListaFocusApi.getLastListFocus().then((ultimaListaFocus) {
      print("ULTIMA LISTA: ${ultimaListaFocus.length}");
    });

    ResponseApi<List<FocusFire>> response = await ListaFocusApi.findFocus();

    if (response.ok) {
      listaFocusFire = response.result;
    }else{
      listaFocusFire = [];
    }

    notifyListeners();

    return response;
  }


}