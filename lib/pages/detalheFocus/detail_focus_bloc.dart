import 'dart:async';

import 'package:queimadas/pages/api/lorem_ipsum.dart';

class DetailFocusBloc {

  static String _textLorem;
  final _detailController = StreamController<String>();

  Stream<String> get strem => _detailController.stream;

  fetch() async {

    var textoGenerico = _textLorem ?? await LoremIpsumApi().findTextRandom();

    _textLorem = textoGenerico;
    _detailController.add(textoGenerico);
  }

  void disponse() {
    _detailController.close();
  }

}