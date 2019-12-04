import 'package:flutter/material.dart';

abstract class DropdownItem {
  String labelShow();
}

class AppDropDraw<T extends DropdownItem> extends StatelessWidget {
  String hint;
  T valueSelected;
  ValueChanged<T> onChangeCallback;
  List<T> listaItens;


  AppDropDraw(this.hint, this.valueSelected, this.onChangeCallback,
      this.listaItens);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
        hint: Text(hint),
        value: valueSelected,
        items: getItems(),
        onChanged: (value){
          onChangeCallback(value);
        });
  }

  List<DropdownMenuItem<T>> getItems() {
    List<DropdownMenuItem<T>> list = listaItens.map<DropdownMenuItem<T>>((valor) {
        return DropdownMenuItem<T>(
          value: valor,
          child: Text("${valor.labelShow}"),
        );

      }).toList();

    return list;
  }

}
