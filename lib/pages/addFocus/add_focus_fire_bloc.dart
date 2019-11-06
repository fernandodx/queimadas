import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:queimadas/eventbus/main_event_bus.dart';
import 'package:queimadas/utils/alert_bottom_sheet.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';


class AddFocusFireBloc {


  final keyForm = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final dataController = TextEditingController();
  final _addFocusController = StreamController<Widget>();

  Stream<Widget> get stream => _addFocusController.stream;

  AddFocusFireBloc get(BuildContext context) => Provider.of<AddFocusFireBloc>(context);

  void fetch() async {
    final imgDefault = CachedNetworkImage(
        imageUrl:
        "https://s3.amazonaws.com/bucket-gw-cni-static-cms-si/portaldaindustria/noticias/media/imagem_plugin_ca42790d-93a8-4f49-abba-527bc1e30d9a.jpg",
      );

//    await Future.delayed(Duration(seconds: 4));

    _addFocusController.add(imgDefault);
  }


  String validatedFieldDefault(String value) {
    if(value == null || value.isEmpty){
      return "Campo Obrigatório";
    }
    return null;
  }

  onPressAdd(context) {
    if(!keyForm.currentState.validate()){
      return;
    }

    alertBottomSheet(context,
        msg: "OK onPress ${descricaoController.text} - ${dataController.text}",
        onPressOk: _onShared );
  }

  addImage(context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("FILE IMAGE: ${image.toString()}");

    if (image != null) {
      _addFocusController.add(Image.file(image));
      MainEventBus().get(context).sendEvent(TipoEvento.event2);
    }
  }

  void dispose() {
    _addFocusController.close();
  }




  _onShared() {
    print("shared");
//    Share.share("http://google.com.br");
    launch("https://www.youtube.com/watch?v=siEkVgo5hTE");
  }
}