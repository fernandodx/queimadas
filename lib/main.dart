import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queimadas/eventbus/main_event_bus.dart';
import 'package:queimadas/model/lista_focus_model.dart';
import 'package:queimadas/pages/SplashScrenn.dart';
import 'package:queimadas/pages/addFocus/add_focus_fire_bloc.dart';
import 'package:queimadas/pages/detalheFocus/detail_focus_bloc.dart';

//Local de variáveis globais

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
            primarySwatch: Colors.lightGreen,
            scaffoldBackgroundColor: Color(0xFFfff6fe)),
//      home: HomePage(),
        home: SplashScreen(),
      ),
    );
  }
}
