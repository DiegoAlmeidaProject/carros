import 'dart:convert' as convert;
import 'carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos =  "classicos";
  static final String esportivos =  "esportivos";
  static final String luxo =  "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';

    print("GET >>> $url"); /*Acompahamento da requisição ao WS*/

    var response = await http.get(url);

    String json = response.body;
    //print(json); /*Print do json no log*/

    List list = convert.json.decode(json);

    /*Boa pratica do flutter fazer desta forma*/
/*   final carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();*/

/*    for (Map map in list) {
      Carro c = Carro.fromJson(map);
      carros.add(c);
    }
*/
    return list.map<Carro>((map) => Carro.fromJson(map)).toList();


  }
}