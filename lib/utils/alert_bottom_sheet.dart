import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/utils/text_util.dart';

alertBottomSheet(
  BuildContext context, {
  @required String msg,
  Function onPressOk,
  String title = "Alerta",
}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.add_alert),
                  title: TextUtil.textDefault(title),
                  subtitle: TextUtil.textDefault(msg),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onPressOk();
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          ),
        );
      });
}
