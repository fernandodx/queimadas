import 'package:flutter/material.dart';
import 'package:queimadas/pages/login/login.dart';
import 'package:queimadas/utils/nav.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}




class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    //TODO Carregar coisas que precisam ser carregadas somente uma vez
    super.initState();

    var futureInit = Future.delayed(Duration(seconds: 3));

    Future.wait([futureInit]).then((listFutureCompleted) {
      push(context, Login());
    });

    //OR home_page.dart

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
