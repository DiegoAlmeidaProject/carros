import 'dart:async';

import 'package:carros/pages/carros/carros_api.dart';
import 'package:carros/pages/carros/simple_bloc.dart';
import 'carro.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  final _streamControler = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamControler.stream;

  Future<List<Carro>> fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      _streamControler.add(carros);

      return carros;

    } catch (e) {
      _streamControler.addError(e);
    }
  }

  void dispose() {
    _streamControler.close();
  }
}