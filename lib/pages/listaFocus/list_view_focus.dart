import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queimadas/eventbus/main_event_bus.dart';
import 'package:queimadas/model/lista_focus_model.dart';
import 'package:queimadas/pages/detalheFocus/detalhe_focus.dart';
import 'package:queimadas/pages/firestore/focus_fire_service.dart';
import 'package:queimadas/pages/listaFocus/lista_focus_bloc.dart';
import 'package:queimadas/utils/alert_bottom_sheet.dart';
import 'package:queimadas/utils/nav.dart';
import 'package:queimadas/utils/text_util.dart';

import '../../focus_fire.dart';

class ListViewFocus extends StatefulWidget {
  @override
  _ListViewFocusState createState() => _ListViewFocusState();
}

class _ListViewFocusState extends State<ListViewFocus>
    with AutomaticKeepAliveClientMixin<ListViewFocus> {
  var _bloc = ListaFocusBloc();
  StreamSubscription<TipoEvento> subscription;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    ListaFocusModel listaFocusModel =
        Provider.of<ListaFocusModel>(context, listen: false);
    listaFocusModel.atualizarListaFocusFire();

    final stream = MainEventBus().get(context).stream;
    subscription = stream.listen((TipoEvento tipo) {
      print("EVENTO RECEBIDO: $tipo");
    });

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ListaFocusModel listaFocusModel = Provider.of<ListaFocusModel>(context);

    if (listaFocusModel.listaFocusFire == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (listaFocusModel.listaFocusFire.isNotEmpty) {
      return _listaViewFocus(listaFocusModel.listaFocusFire,
          scrollController: _bloc.scrollController);
    } else {
      return Center(
        child: TextUtil.textDefault("Não Existe nenhum Focus de fogo"),
      );
    }

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

  _listaViewFocus(List<FocusFire> listaFocus, {scrollController}) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
        child: ListView.builder(
            controller: scrollController,
            itemCount: listaFocus.length,
            itemBuilder: (context, index) {
              FocusFire focus = listaFocus[index];
              _bloc.fetchTeste(focus);
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
                            icon: Icon(
                              Icons.data_usage,
                              color: Colors.lightGreen,
                            ),
                          ),
                          StreamBuilder<bool>(
                              stream: _bloc.streamFavorito,
                              builder: (context, snapshot) {
                                ColorSwatch colorFavorite = Colors.grey;
                                String animation = "Like";
//                                if (snapshot.hasData && snapshot.data) {
//                                  colorFavorite = Colors.redAccent;
//                                  animation = "Dislike";
//                                }

//                                return InkWell(
//                                  onTap: () => _onClickMonitorarFocus(focus),
//                                  child: FlareActor(
//                                    "assets/animations/like_animation.flr",
//                                    color: colorFavorite,
//                                    shouldClip: false,
//                                    animation: animation,
//                                  ),
//                                );

                                return IconButton(
                                  onPressed: () => _onClickMonitorarFocus(focus),
                                  icon: Icon(Icons.favorite_border, color: colorFavorite,),
                                );
                              })
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

  void _onClick() {}

  _onClickMonitorarFocus(FocusFire focus) async {
    var isExiste = await FocusFireService().saveMonitorFocus(focus);
    _bloc.atualizarFavorito(isExiste);
  }
}
