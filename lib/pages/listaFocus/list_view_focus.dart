import 'package:flutter/material.dart';
import 'package:queimadas/pages/detalheFocus/detalhe_focus.dart';
import 'package:queimadas/utils/alert.dart';
import 'package:queimadas/utils/nav.dart';

import '../../focus_fire.dart';
import '../../response_api.dart';
import 'lista_focus_api.dart';

class ListViewFocus extends StatefulWidget {
  @override
  _ListViewFocusState createState() => _ListViewFocusState();
}

class _ListViewFocusState extends State<ListViewFocus>
    with AutomaticKeepAliveClientMixin<ListViewFocus> {

  List<FocusFire> listaFocus;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _loadData();

  }

  _loadData() async {

    ListaFocusApi.getLastListFocus().then((ultimaListaFocus) {
      print("ULTIMA LISTA: ${ultimaListaFocus.length}");
    });

    ResponseApi<List<FocusFire>> response = await ListaFocusApi.findFocus();
    if (response.ok) {
      print("LISTA ATUAL: ${response.result.length}");
      setState(() {
        listaFocus = response.result;
      });
    }else{
      simpleAlert(context, msg: "Não foi possível carregar a lista de focus");
    }

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if(listaFocus == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return _listaViewFocus(listaFocus);
  }

  _onClickDetalhar(focus) {
    push(context, DetalheFocus(focus));
  }

  _listaViewFocus(List<FocusFire> listaFocus) {
    return Container(
      child: ListView.builder(
          itemCount: listaFocus.length,
          itemBuilder: (context, index) {
            FocusFire focus = listaFocus[index];
            return Card(
              elevation: 16,
              margin: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Image.network(
                      "https://as2.ftcdn.net/jpg/01/00/85/99/500_F_100859967_c6ZqB8d3nTyoupX79CanujbOJHLPtMiM.jpg"),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Image.network(
                            "https://www.countryflags.io/br/flat/64.png"),
                        Container(
                          margin: EdgeInsets.only(
                              left: 12.0, top: 0, right: 0, bottom: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                focus.country,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "Quantidade: ${focus.count}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                            onPressed: () => _onClickDetalhar(focus),
                            child: Text("Detalhar")),
                        FlatButton(
                          onPressed: () {},
                          child: Text("Favoritar"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
