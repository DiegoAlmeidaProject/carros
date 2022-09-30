import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carros/loripsum_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/text.dart';
import 'carro.dart';

class CarroPage extends StatefulWidget {

  Carro carro;

  CarroPage(this.carro);

  @override
  State<CarroPage> createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();

  @override
  void initState(){
    super.initState();

    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.carro.nome),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.place),
              onPressed: _onClickMapa,
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: _onClickVideo,
            ),
            PopupMenuButton<String>(
              onSelected: (String value) => _onClickPopupMenu(value),
              itemBuilder: (BuildContext context) {
                return [PopupMenuItem(value: "Editar" ,child: Text("Editar"),),
                PopupMenuItem(value: "Deletar" ,child: Text("Deletar"),),
                PopupMenuItem(value: "Share" ,child: Text("Share"),),
                ];
              },
            ),
          ],
        ),
        body: _body());
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView (
        children: <Widget>[
          CachedNetworkImage(
              imageUrl:widget.carro.urlFoto),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
     ),
    );
  }

  Row _bloco1() {
    return Row(
          children:<Widget> [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  text(widget.carro.nome, fontSize: 20, bold: true),
                  text(widget.carro.tipo, fontSize: 16),
                ],
              ),
            ),
            Row(
              children: <Widget> [
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red, size: 40,),
                  onPressed: _onClickFavorito,
                ),
                IconButton(
                  icon: Icon(Icons.share, size: 40,),
                  onPressed: _onClickShare,
                ),
              ],
            ),
          ],
        );
  }

  _bloco2(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(widget.carro.descricao, fontSize: 16, bold: true),
        SizedBox(height: 20,),
        StreamBuilder(
          stream: _loripsumApiBloc.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }
              return text(snapshot.data, fontSize: 16);
            },
        ),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch(value) {
      case "Editar":
        print("Editar !!!");
        break;
      case "Deletar":
        print("Deletar !!!");
        break;
      case "Share":
        print("Share !!!");
        break;
    }
  }

  void _onClickFavorito() {
  }

  void _onClickShare() {
  }

  @override
  void dispose() {
    super.dispose();

    _loripsumApiBloc.dispose();
  }
}
