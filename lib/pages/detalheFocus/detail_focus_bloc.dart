import 'dart:async';

import 'package:queimadas/pages/api/lorem_ipsum.dart';
import 'package:queimadas/pages/listaFocus/lista_focus_api.dart';

class DetailFocusBloc {

  static String _textLorem;
  final _detailController = StreamController<String>();

  Stream<String> get strem => _detailController.stream;

  fetch() async {

//    var response = await ListaFocusApi.findFocusDetail("Brasil");



    var textoGenerico = _textLorem ?? await LoremIpsumApi().findTextRandom();

    _textLorem = textoGenerico;
    _detailController.add(textoGenerico);
  }

  void disponse() {
    _detailController.close();
  }

}