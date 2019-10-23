import 'package:flutter/material.dart';
import 'package:queimadas/pages/addFocus/add_focus_fire.dart';
import 'package:queimadas/pages/listaFocus/list_view_focus.dart';
import 'package:queimadas/pages/login/login.dart';
import 'package:queimadas/utils/alert.dart';
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

  @override
  void initState() {
    super.initState();

    _initTabController();
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
              text: "DADOS",
              icon: Icon(Icons.pie_chart),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Container(color: Colors.redAccent),
        ListViewFocus(),
        Container(color: Colors.greenAccent),
      ]),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Nome"),
              accountEmail: Text("E-mail"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatarfiles.alphacoders.com/115/115265.png"),
              ),
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

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, Login(), isReplace: true);
  }

  _onClickAddLocais(BuildContext context) {
    push(context, AddFocusFire());
  }
}
