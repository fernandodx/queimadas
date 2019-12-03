import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/eventbus/main_event_bus.dart';
import 'package:queimadas/pages/addFocus/add_focus_fire.dart';
import 'package:queimadas/pages/api/firebase_service.dart';
import 'package:queimadas/pages/cadastro/cadastro.dart';
import 'package:queimadas/pages/focusMaps/focus_map.dart';
import 'package:queimadas/pages/listaFocus/list_view_focus.dart';
import 'package:queimadas/pages/listaFocus/list_view_monitor_focus.dart';
import 'package:queimadas/pages/login/login.dart';
import 'package:queimadas/pages/login/login_bloc.dart';
import 'package:queimadas/utils/alert.dart';
import 'package:queimadas/utils/alert_bottom_sheet.dart';
import 'package:queimadas/utils/nav.dart';
import 'package:queimadas/utils/prefs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {

  final KEY_ABA_SELECIONADA = "KEY_ABA_SELECIONADA";
  static const int QTD_ABAS = 3;
  TabController _tabController;
  StreamSubscription streamSubscription;
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _initTabController();
    _checkMsgWelcome();

    streamSubscription =  MainEventBus().get(context).streamUser.listen((user) {
      print("Usuário UPDATE:  ${user.email}");
    });
  }

  @override
  void dispose() {
    super.dispose();

    streamSubscription.cancel();
  }

  void _checkMsgWelcome() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    if (remoteConfig.getBool("IS_SHOW_MSG")) {
      alertBottomSheet(context, msg: remoteConfig.getString("MSG_WELLCOME"));
    }
  }

  void _initTabController() {
    _tabController = TabController(length: QTD_ABAS, vsync: this);

    Prefs.getInt(KEY_ABA_SELECIONADA).then((index) {
      _tabController.index = index;
    });

    _tabController.addListener(() {
      print(_tabController.index);
      Prefs.putInt(KEY_ABA_SELECIONADA, _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Queimadas"),
        bottom: TabBar(
          indicatorColor: Colors.grey,
          labelColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(
              text: "FOCUS",
              icon: Icon(Icons.map),
            ),
            Tab(
              text: "LOCAIS",
              icon: Icon(Icons.list),
            ),
            Tab(
              text: "FAVORITOS",
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        FocusMap(),
        ListViewFocus(),
        ListViewMonitorFocus(),
      ]),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            StreamBuilder<FirebaseUser>(
                stream: MainEventBus().get(context).streamUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _userAccountHeader(snapshot.data);
                  }

                  return FutureBuilder(
                    future: FirebaseAuth.instance.currentUser(),
                    builder: (context, snapshot){
                      if (snapshot.hasData) {
                        return _userAccountHeader(snapshot.data);
                      }
                      return Center(child: CircularProgressIndicator());
                  },);

                }),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Editar"),
              subtitle: Text("Alterar informações da conta"),
              onTap: () => _onClickEditUser(context),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              subtitle: Text("Finalizar sessão"),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.lightGreenAccent,
        onPressed: () => _onClickAddLocais(context),
      ),
    );
  }

  _userAccountHeader(FirebaseUser user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.displayName ?? ""),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.photoUrl ??
            "https://cdn3.iconfinder.com/data/icons/avatars-15/64/_Bearded_Man-17-512.png"),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, Login(), isReplace: true);
  }

  _onClickAddLocais(BuildContext context) {
    push(context, AddFocusFire());
  }

  _onClickEditUser(context) {
    print("CLICK EDITAR CONTA");
    FirebaseAuth.instance.currentUser().then((user) {
      push(context, RegisterOrUpdate.withUser(user));
    });
  }
}
