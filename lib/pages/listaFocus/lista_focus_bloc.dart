import 'dart:async';

import 'package:queimadas/Focus.dart';

import '../../ResponseApi.dart';
import 'lista_focus_api.dart';

class ListaFocusBloc {

  final _listaFocusConstroller = StreamController<List<Focus>>();

  Stream<List<Focus>> get stream => _listaFocusConstroller.stream;


  fetch() async {
    ListaFocusApi.getLastListFocus().then((ultimaListaFocus) {
      print("ULTIMA LISTA: ${ultimaListaFocus.length}");
    });

    ResponseApi<List<Focus>> response = await ListaFocusApi.findFocus();

    if (response.ok) {
      print("LISTA ATUAL: ${response.result.length}");
      _listaFocusConstroller.add(response.result);

    } else {
      _listaFocusConstroller.addError(response.msg);
    }
  }



  void dispose() {
    _listaFocusConstroller.close();
  }


}