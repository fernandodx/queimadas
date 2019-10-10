import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String msgError;

  TextError(this.msgError);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          msgError,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
