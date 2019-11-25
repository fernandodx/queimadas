import 'dart:convert' as convert;

class FocusFire {

  String country;
  int count;

  FocusFire(this.country, this.count);

  static createListFocusWithJson(resposeJson) {
    Map focusMap = convert.json.decode(resposeJson);
    List<FocusFire> listaFocus = List();

    focusMap.forEach((key, value) {
      var focus = FocusFire(key, value);
      listaFocus.add(focus);
    });

    return listaFocus;
  }


  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['count'] = this.count;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

}