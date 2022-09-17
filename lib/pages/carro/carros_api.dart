
import 'carro.dart';

class CarrosApi {
  static List<Carro> getCarros() {
    final carros = List<Carro>();

    carros.add(Carro(nome: "Renault Megane RS Trophi2", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Renault_Megane_Trophy.png"));
    carros.add(Carro(nome: "Ferrari FF", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Maserati_Grancabrio_Sport.png"));
    carros.add(Carro(nome: "MERCEDES-BENZ C63 AMG", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/MERCEDES_BENZ_AMG.png"));

    return carros;
  }
}