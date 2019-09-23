import 'package:flutter/material.dart';

class AppButtonDefault extends StatelessWidget {
  String label;
  Function onPressed;
  bool isShowProgress;

  AppButtonDefault(
      {this.label, @required this.onPressed, this.isShowProgress = false});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.all(2),
        child: getTextButton(),),
      color: Colors.lightGreen,
      textColor: Colors.white,
      onPressed: onPressed,
    );
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
      style: TextStyle(
        fontSize: 17,
      ),
    );
  }
}
