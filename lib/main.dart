import 'package:flutter/material.dart';
import 'package:queimadas/pages/SplashScrenn.dart';

//Local de variáveis globais

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Queimadas',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: Color(0xFFfff6fe)

      ),
//      home: HomePage(),
    home: SplashScreen(),
    );
  }
}
