import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/pages/firestore/focus_fire_service.dart';

import '../../response_api.dart';
import 'lista_focus_api.dart';

class ListaFocusBloc {
  final _listaFocusConstroller = StreamController<List<FocusFire>>();
  final _favoritoController = StreamController<bool>.broadcast();

  var scrollController = ScrollController();

  Stream<List<FocusFire>> get stream => _listaFocusConstroller.stream;
  Stream<bool> get streamFavorito => _favoritoController.stream;

  Future<List<FocusFire>> fetch() async {

    scrollController.addListener((){
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        print("----- FIM DO SCROLL DA LISTA -----");
      }
    });

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

  fetchTeste(focus) async {

    bool isExiste = await FocusFireService().isExist(focus);
    _favoritoController.add(isExiste);

  }

  void atualizarFavorito(isExiste) {
    _favoritoController.add(isExiste);
  }

  void dispose() {
    _listaFocusConstroller.close();
  }
}
