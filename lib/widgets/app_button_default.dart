import 'package:flutter/material.dart';

class AppButtonDefault extends StatelessWidget {
  String label;
  Function onPressed;
  bool isShowProgress;
  TypeButton type;
  TextDecoration decoration;

  AppButtonDefault(
      {this.label,
      @required this.onPressed,
      this.isShowProgress = false,
      this.type = TypeButton.RAISE,
      this.decoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TypeButton.FLAT:
        return FlatButton(
          child: Container(
            padding: EdgeInsets.all(2),
            child: getTextButton(),
          ),
          textColor: Colors.lightGreen,
          onPressed: onPressed,
        );
        break;
      case TypeButton.RAISE:
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.all(2),
            child: getTextButton(),
          ),
          color: Colors.lightGreen,
          textColor: Colors.white,
          onPressed: onPressed,
        );
    }
  }

  Widget getTextButton() {
    if (isShowProgress) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    }
    return Text(
      label,
      style: TextStyle(fontSize: 17, decoration: decoration),
    );
  }
}

enum TypeButton { RAISE, FLAT }
