import 'package:flutter/material.dart';
import 'package:queimadas/Focus.dart';

class DetalheFocus extends StatelessWidget {
  Focus focus;

  DetalheFocus(this.focus);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(focus.country),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Text(
            "Quantidade de Focus: ${focus.count}",
            style: TextStyle(fontSize: 35),
          ),
        ),
      ),
    );
  }
}
