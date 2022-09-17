import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class HomePage extends StatelessWidget {
  get future => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    Future<List<Carro>> future = CarrosApi.getCarros();

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {

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
                      c.urlFoto,
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome,
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
                          onPressed: () {
                            /* ... */
                          },
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
}
