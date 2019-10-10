import 'dart:async';

import 'package:queimadas/pages/api/lorem_ipsum.dart';

class DetailFocusBloc {

  final _detailController = StreamController<String>();

  Stream<String> get strem => _detailController.stream;

  fetch() async {
    var textoGenerico = await LoremIpsumApi().findTextRandom();
    _detailController.add(textoGenerico);
  }

  void disponse() {
    _detailController.close();
  }

}