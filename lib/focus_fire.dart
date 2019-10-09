import 'dart:convert';

class FocusFire {

  String country;
  int count;

  FocusFire(this.country, this.count);

  static createListFocusWithJson(resposeJson) {
    Map focusMap = json.decode(resposeJson);
    List<FocusFire> listaFocus = List();

    focusMap.forEach((key, value) {
      var focus = FocusFire(key, value);
      listaFocus.add(focus);
    });

    return listaFocus;
  }

}