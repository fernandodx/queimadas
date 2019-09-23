import 'dart:convert';

class Focus {

  String country;
  int count;

  Focus(this.country, this.count);

  static createListFocusWithJson(resposeJson) {
    Map focusMap = json.decode(resposeJson);
    List<Focus> listaFocus = List();

    focusMap.forEach((key, value) {
      var focus = Focus(key, value);
      listaFocus.add(focus);
    });

    return listaFocus;
  }

}