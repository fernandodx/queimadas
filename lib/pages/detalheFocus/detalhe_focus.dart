import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/pages/detalheFocus/detail_focus_bloc.dart';
import 'package:queimadas/utils/text_util.dart';

class DetalheFocus extends StatefulWidget {
  FocusFire focus;

  DetalheFocus(this.focus);

  @override
  _DetalheFocusState createState() => _DetalheFocusState();
}

class _DetalheFocusState extends State<DetalheFocus> {
  DetailFocusBloc get _detailFocusBloc => Provider.of<DetailFocusBloc>(context);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1)).then((value) {
      _detailFocusBloc.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.focus.country),
//        actions: _actionsAppBar(),
//      ),
      body: _getSCrollViewSliver(widget.focus.country),
    );
  }

  List<Widget> _actionsAppBar() {
    return [
      IconButton(
          icon: Icon(
            Icons.favorite,
          ),
          onPressed: _onClickFavorite()),
      IconButton(
        icon: Icon(Icons.share),
        onPressed: _onClickShared(),
      ),
      PopupMenuButton<String>(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "EDITAR",
              child: Text("editar"),
            ),
            PopupMenuItem(
              value: "EXCLUIR",
              child: Text("Excluir"),
            ),
          ];
        },
      )
    ];
  }

  Center _bodyDetail() {
    return Center(
      child: Column(
        children: <Widget>[
          Hero(
            tag: widget.focus.country,
            child: CachedNetworkImage(
                imageUrl: "https://www.countryflags.io/br/flat/64.png"),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextUtil.textDefault(
                "Quantidade de Focus: ${widget.focus.count}"),
          ),
          SizedBox(height: 20),
          StreamBuilder(
              stream: _detailFocusBloc.strem,
              initialData: "Carregando",
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return TextUtil.textDefault(snapshot.data);
                }
                if (snapshot.hasError) {
                  return TextUtil.textDefault(snapshot.error);
                }

                return TextUtil.textTitulo("Carreando...");
              }),
          SizedBox(
            height: 20,
          ),
          _getSCrollViewSliver(widget.focus.country)
        ],
      ),
    );
  }

  _onClickFavorite() {}

  _onClickShared() {}

  _getSCrollViewSliver(String title) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: _actionsAppBar(),
          backgroundColor: Colors.lightGreen,
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: TextUtil.textTitulo(title),
            centerTitle: false,
            collapseMode: CollapseMode.parallax,
            background: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    "https://s3.amazonaws.com/uploads.hotmart.com/blog/2019/10/BLOG_google-photos-670x419.png"),
          ),
        ),
        SliverFillRemaining(
            child: Container(
          padding: EdgeInsets.all(16),
          child: TextUtil.textDefault(
              "Assim mesmo, a complexidade dos estudos efetuados representa uma abertura para a melhoria dos paradigmas corporativos."),
        )),
      ],
    );
  }
}
