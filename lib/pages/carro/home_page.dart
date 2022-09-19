import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  get future => null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros",),
          bottom: TabBar(tabs: [
            Tab(text: "Clássicos",),
            Tab(text: "Esportivo",),
            Tab(text: "Luxo",)
          ]),
        ),
        body: TabBarView(
          children: [
            CarrosListView(TipoCarro.classicos),
            CarrosListView(TipoCarro.esportivos),
            CarrosListView(TipoCarro.luxo),

          ],
        ),
        drawer: DrawerList(),
      ),
    );
  }
}
