import 'dart:async';
import 'package:carros/pages/carros/simple_bloc.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import '../carros/carro.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>> {
  final _streamControler = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamControler.stream;

  Future<List<Carro>> fetch() async {
    try {

      List<Carro> carros = await FavoritoService.getCarros();

      _streamControler.add(carros);

      return carros;
    } catch (e) {
      print(e);
      if (! _streamControler.isClosed) {
        _streamControler.addError(e);
      }
    }
  }

  void dispose() {
    _streamControler.close();
  }
}