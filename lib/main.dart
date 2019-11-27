import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queimadas/eventbus/main_event_bus.dart';
import 'package:queimadas/model/lista_focus_model.dart';
import 'package:queimadas/pages/SplashScrenn.dart';
import 'package:queimadas/pages/addFocus/add_focus_fire_bloc.dart';
import 'package:queimadas/pages/detalheFocus/detail_focus_bloc.dart';

//Local de variáveis globais

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    _initDefaultFirebaseRemoteConfig();
    _initFcm();


  }

  void _initFcm(){

    FirebaseMessaging fcm = FirebaseMessaging();
    fcm.getToken().then((token) => print("TOKEN FCM = $token"));

    fcm.configure(
      onMessage: (Map<String, dynamic> messages) async {
        print("onMessage: $messages");
      },
      onLaunch: (Map<String, dynamic> messages) async {
        print("onLaunch: $messages");
      },
      onResume: (Map<String, dynamic> messages) async {
        print("onResume: $messages");
      }
    );

    if(Platform.isIOS){
      fcm.requestNotificationPermissions((IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true
      )));
      fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings){
        print("IOS Settings : $settings");
      });
    }


  }

  void _initDefaultFirebaseRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    Map<String, dynamic> defaults = {
      'MSG_WELLCOME': 'Olá Bem vindo ao app Queimadas! OFFLINE',
      'IS_SHOW_MSG': true
    };

    //Alterar para subir para produção
    remoteConfig.setDefaults(defaults);
    remoteConfig.fetch(expiration: const Duration(minutes: 1));
    remoteConfig.activateFetched();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DetailFocusBloc>(
          builder: (context) => DetailFocusBloc(),
          dispose: (context, detailFocus) => detailFocus.disponse(),
        ),
        Provider<MainEventBus>(
          builder: (context) => MainEventBus(),
          dispose: (context, mainEventBus) => mainEventBus.dispose(),
        ),
        ChangeNotifierProvider<ListaFocusModel>(
          builder: (context) => ListaFocusModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Queimadas',
        theme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Color(0xFFfff6fe)),
//      home: HomePage(),
        home: SplashScreen(),
      ),
    );
  }
}
