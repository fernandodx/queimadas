import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queimadas/eventbus/main_event_bus.dart';
import 'package:queimadas/model/lista_focus_model.dart';
import 'package:queimadas/pages/api/firebase_service.dart';
import 'package:queimadas/pages/detalheFocus/detalhe_focus.dart';
import 'package:queimadas/pages/firestore/focus_fire_service.dart';
import 'package:queimadas/pages/listaFocus/lista_focus_bloc.dart';
import 'package:queimadas/response_api.dart';
import 'package:queimadas/utils/alert_bottom_sheet.dart';
import 'package:queimadas/utils/nav.dart';
import 'package:queimadas/utils/text_util.dart';
import 'package:queimadas/widgets/app_text_default.dart';
import 'package:queimadas/widgets/text_error.dart';

import '../../focus_fire.dart';

class ListViewMonitorFocus extends StatefulWidget {
  @override
  _ListViewMonitorFocusState createState() => _ListViewMonitorFocusState();
}

class _ListViewMonitorFocusState extends State<ListViewMonitorFocus>
    with AutomaticKeepAliveClientMixin<ListViewMonitorFocus> {
//  var _bloc = ListaFocusBloc();
  StreamSubscription<TipoEvento> subscription;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

//    ListaFocusModel listaFocusModel =
//        Provider.of<ListaFocusModel>(context, listen: false);
//    listaFocusModel.atualizarListaFocusFire();

    final stream = MainEventBus().get(context).stream;
    subscription = stream.listen((TipoEvento tipo) {
      print("EVENTO RECEBIDO: $tipo");
    });

//    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FocusFireService service = FocusFireService();

    return StreamBuilder(
        stream: service.getMonitorFocusFire(),
        builder: (context, snapshot) {

          if(snapshot.hasData){

            var listaFocus = service.toList(snapshot);
            if (listaFocus.isNotEmpty) {
              return _listaViewFocus(listaFocus);
            } else {
              return Center(
                child: TextUtil.textDefault("Não Existe nenhum Focus Favorito"),
              );
            }
          }

          if (snapshot.hasError) {
            return TextError(snapshot.error);
          }

          return CircularProgressIndicator();

        });


//    ListaFocusModel listaFocusModel = Provider.of<ListaFocusModel>(context);

//    if (listaFocusModel.listaFocusFire == null) {
//      return Center(
//        child: CircularProgressIndicator(),
//      );
//    }

//    if (listaFocusModel.listaFocusFire.isNotEmpty) {
//      return _listaViewFocus(listaFocusModel.listaFocusFire);
//    } else {
//      return Center(
//        child: TextUtil.textDefault("Não Existe nenhum Focus de fogo"),
//      );
//    }

//    return StreamBuilder(
//      stream: _bloc.stream,
//      builder: (context, snapshot) {
//        if (snapshot.hasError) {
////          simpleAlert(context, msg: "ERRO"); Descobrir porque não funcionou
//          return TextError(snapshot.error);
//        }
//
//        if (snapshot.hasData) {
//          return _listaViewFocus(snapshot.data);
//        }
//
//        return Center(
//          child: CircularProgressIndicator(),
//        );
//      },
//    );
  }

  _onClickDetalhar(focus) {
    push(context, DetalheFocus(focus));
  }

  _listaViewFocus(List<FocusFire> listaFocus) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
        child: ListView.builder(
            itemCount: listaFocus.length,
            itemBuilder: (context, index) {
              FocusFire focus = listaFocus[index];
              return Card(
                elevation: 16,
                margin: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onLongPress: () => _onLongPressImage(),
                      onTap: _onClick,
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://as2.ftcdn.net/jpg/01/00/85/99/500_F_100859967_c6ZqB8d3nTyoupX79CanujbOJHLPtMiM.jpg",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          CachedNetworkImage(
                              imageUrl:
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
                          IconButton(
                            onPressed: () => _onClickDetalhar(focus),
                            icon: Icon(Icons.data_usage, color: Colors.lightGreen,),
                          ),
                          IconButton(
                            onPressed: () => _onClickMonitorarFocus(focus),
                            icon: Icon(Icons.favorite_border, color: Colors.grey,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<void> _onRefresh() {
    print("LISTA ATUALIZADO");
    return Provider.of<ListaFocusModel>(context, listen: false)
        .atualizarListaFocusFire();
  }

  @override
  void dispose() {
    super.dispose();

    subscription.cancel();

//    _bloc.dispose();
  }

  _onLongPressImage() {

    alertBottomSheet(context, msg: "On Long Press foi acionado.");
  }

  void _onClick() {
  }

  _onClickMonitorarFocus(FocusFire focus) {
    FocusFireService().saveMonitorFocus(focus);
  }
}
