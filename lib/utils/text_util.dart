import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextUtil {

  static Text textDefault(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 14,
        color: Colors.blueGrey,
      ),
    );
  }

  static Text textTitulo(String value) {
    return Text(
      value,
      style: TextStyle(
          fontSize: 20,
          color: Colors.lightGreenAccent,
          fontWeight: FontWeight.bold),
    );
  }
}
