
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
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("Home build, ${widget.tipo}");

    Future<List<Carro>> future = CarrosApi.getCarros(widget.tipo);

    return FutureBuilder(
      future: future,
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

        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
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

}
