import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/utils/text_util.dart';
import 'package:queimadas/widgets/app_button_default.dart';
import 'package:queimadas/widgets/app_text_default.dart';

class AddFocusFire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextUtil.textTitulo("Adicionar um focus de Queimada"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: "https://s3.amazonaws.com/bucket-gw-cni-static-cms-si/portaldaindustria/noticias/media/imagem_plugin_ca42790d-93a8-4f49-abba-527bc1e30d9a.jpg",
            ),
            SizedBox(height: 20,),
            AppTextDefault(
              name: "Descrição",
              hint: "Descrição",
            ),
            SizedBox(height: 20,),
            AppTextDefault(
              name: "Data",
              hint: "Data",
            ),
            SizedBox(height: 20,),
            AppButtonDefault(
              label: "Adicionar",
              onPressed: () => _onPressAdd(),
            )
          ],
        ),
      ),
    );
  }

  _onPressAdd() {}
}
