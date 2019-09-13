import 'package:flutter/material.dart';
import 'package:queimadas/pages/home_page.dart';
import 'package:queimadas/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Queimadas',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Color(0xFFfff6fe)

      ),
//      home: HomePage(),
    home: Login(),
    );
  }
}
