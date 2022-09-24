
import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  State<CarrosListView> createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView> {
<<<<<<< HEAD

  List<Carro> carros;
=======
  List<Carro> carros;
  final _streamController = StreamController<List<Carro>>();
>>>>>>> StreamsStreamBuilder

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
<<<<<<< HEAD
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<List<Carro>> future = CarrosApi.getCarros(widget.tipo);

    future.then((List<Carro> carros) {
      setSatte() {
        this.carros = carros;
    };
    });
=======
  void initState(){
    super.initState();
    _loadCarros();
  }

  _loadCarros() async {
    List<Carro> carros = await CarrosApi.getCarros(widget.tipo);
    _streamController.add(carros);
>>>>>>> StreamsStreamBuilder
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("carrosListView build, ${widget.tipo}");

<<<<<<< HEAD
    if (carros == null) {
      return Center(child: CircularProgressIndicator(),);
    }

    return _listView(carros);
=======

    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text(
              "Não foi possivel buscar os carros!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        if (! snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
>>>>>>> StreamsStreamBuilder

  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[200],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      c.urlFoto ?? "http://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/Cadillac_Eldorado.png",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome ?? "SEM NOME",
                    maxLines: 1,
                    /*Conteudo deve se auto adaptar no container do Flexible em uma linha cada objeto*/
                    overflow: TextOverflow.ellipsis,
                    /*Define os tres pontinhos na descrição quando não cabe na widget do Flexible*/
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(c),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

}
