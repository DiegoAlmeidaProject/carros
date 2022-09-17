import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class HomePage extends StatelessWidget {
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
    List<Carro> carros = CarrosApi.getCarros();

    return ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Row(
            children: <Widget>[
              Image.network(
                c.urlFoto,
                width: 150,
              ),
              Flexible( /*Realiza o ajuste do conteudo automaticamente na tela, não estourando o espaço.(Ficando amarelo)*/
                child: Text(
                  c.nome,
                  maxLines: 1, /*Conteudo deve se auto adaptar no container do Flexible em uma linha cada objeto*/
                  overflow: TextOverflow.ellipsis, /*Define os tres pontinhos na descrição quando não cabe na widget do Flexible*/
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        });
  }
}
