import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool isReplace = false}) {
  if(isReplace){
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}


bool pop(BuildContext context, result) {
  return Navigator.pop(context, result);
}