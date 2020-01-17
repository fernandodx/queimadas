import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/model/lista_focus_model.dart';

class ListViewFireFocus extends StatelessWidget{

  List<FocusFire> listaFocus;
  Function onRefresh;
  Function onLongPressImage;
  Function(FocusFire) onClick;
  Function(FocusFire) onClickDetalhar;
  Function(FocusFire) onClickMonitorarFocus;


  ListViewFireFocus(this.listaFocus, {this.onLongPressImage,
      this.onClick, this.onClickDetalhar, this.onClickMonitorarFocus});

  @override
  Widget build(BuildContext context) {

      return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
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
                        onLongPress: () => onLongPressImage(),
                        onTap: () => onClick(focus),
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
                            Hero(
                              tag: focus.country,
                              child: CachedNetworkImage(
                                  imageUrl:
                                  "https://www.countryflags.io/br/flat/64.png"),
                            ),
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
                              onPressed: () => onClickDetalhar(focus),
                              icon: Icon(
                                Icons.data_usage,
                                color: Colors.lightGreen,
                              ),
                            ),
                            IconButton(
                              onPressed: () => onClickMonitorarFocus(focus),
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                              ),
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

  Future<void> _onRefresh(BuildContext context) {
    print("LISTA ATUALIZADO");
    return Provider.of<ListaFocusModel>(context, listen: false)
        .atualizarListaFocusFire();
  }
}