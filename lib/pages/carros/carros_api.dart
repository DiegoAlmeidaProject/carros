import 'dart:convert' as convert;
import 'package:carros/pages/login/usuario.dart';

import 'carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos =  "classicos";
  static final String esportivos =  "esportivos";
  static final String luxo =  "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    Usuario user = await Usuario.get();

    Map<String,String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    //print(headers); /*Para visualizar a requisição do headers*/

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("GET >>> $url"); /*Acompahamento da requisição ao WS*/

    var response = await http.get(url, headers: headers);

    String json = response.body;
    print("status code: ${response.statusCode}");
    print(json); /*Print do json no log*/

    try {
      List list = convert.json.decode(json);

      /*Boa pratica do flutter fazer desta forma*/
      final carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

/*    for (Map map in list) {
      Carro c = Carro.fromJson(map);
      carros.add(c);
    }
*/
      return carros;
    } catch (error, exception) {
      print("$error > $exception");
      throw error;
    }


  }
}