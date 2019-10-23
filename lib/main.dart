import 'package:flutter/material.dart';
import 'package:queimadas/pages/SplashScrenn.dart';
import 'package:queimadas/pages/home_page.dart';
import 'package:queimadas/pages/login/login.dart';

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
