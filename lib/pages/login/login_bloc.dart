
import 'dart:async';

import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/carros/simple_bloc.dart';
import 'package:carros/pages/login/usuario.dart';

import '../api_response.dart';
import 'login_api.dart';

class LoginBloc {
  final buttonBloc = BooleanBloc();

  Future<ApiResponse> login(String login, String senha) async {

    buttonBloc.add(true);

    //ApiResponse response = await LoginApi.login(login, senha);
    ApiResponse response = await FirebaseService().login(login, senha); //login pelo firebase, usuario e senha já cadastrados

    buttonBloc.add(false);

    return response;

  }

  void dispose(){
    buttonBloc.dispose();
  }

}