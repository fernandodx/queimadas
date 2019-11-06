import 'dart:async';

import 'package:queimadas/focus_fire.dart';

import '../../response_api.dart';
import 'lista_focus_api.dart';

class ListaFocusBloc {
  final _listaFocusConstroller = StreamController<List<FocusFire>>();

  Stream<List<FocusFire>> get stream => _listaFocusConstroller.stream;

  Future<List<FocusFire>> fetch() async {
    ListaFocusApi.getLastListFocus().then((ultimaListaFocus) {
      print("ULTIMA LISTA: ${ultimaListaFocus.length}");
    });

    ResponseApi<List<FocusFire>> response = await ListaFocusApi.findFocus();

    if (response.ok) {
      print("LISTA ATUAL: ${response.result.length}");
      _listaFocusConstroller.add(response.result);
    } else {
      _listaFocusConstroller.addError(response.msg);
    }

    return response.result;
  }

  void dispose() {
    _listaFocusConstroller.close();
  }
}
