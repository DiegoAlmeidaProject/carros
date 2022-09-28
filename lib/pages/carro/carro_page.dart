import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/text.dart';
import 'carro.dart';

class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(carro.nome),
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
          Image.network(carro.urlFoto),
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
                  text(carro.nome, fontSize: 20, bold: true),
                  text(carro.tipo, fontSize: 16),
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
        text(carro.descricao, fontSize: 16, bold: true),
        SizedBox(height: 20,),
        text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", fontSize: 16),

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
}
