import 'package:flutter/material.dart';
import 'package:queimadas/pages/listaFocus/lista_focus.dart';
import 'package:queimadas/pages/login/login.dart';
import 'package:queimadas/utils/nav.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Queimadas"),
          bottom: TabBar(tabs: [
            Text("PAGE 1"),
            Text("PAGE 2")
          ]),
        ),
        body: TabBarView(children: [
         ListaFocus(),
          Container(
            color: Colors.greenAccent,
          )
        ]),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Nome"),
                accountEmail: Text("E-mail"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://avatarfiles.alphacoders.com/115/115265.png"),
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
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, Login(), isReplace: true);
  }
}
