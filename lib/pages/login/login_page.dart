import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'login_api.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _bloc = LoginBloc();

  final _tlogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focussenha = FocusNode();

  bool _showProgress = false;

  @override
  void initState() {
    super.initState();

    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      if (user != null) {
        push(context, HomePage(), replace: true);
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(), //TODO: Corpo da pagina de login
    );
  }

  _body() {
    //bool _showProgress = true; //Descomentar apenas para teste da animação circular de carregamento da ação no botão login,
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText("Login", "Digite o login",
                controller: _tlogin,
                validator: _validateLogin,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                nextFocus: _focussenha),
            SizedBox(
              height: 10,
            ),
            AppText("Senha", "Digite a senha",
                password: true,
                controller: _tSenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focussenha),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: _bloc.buttonBloc.stream, /*Se "Conecta a variavel _streamControllr"*/
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data ?? false,
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    bool formaOk = _formKey.currentState?.validate();
    if (!formaOk) {
      return;
    }

    String login = _tlogin.text;
    String senha = _tSenha.text;

    print("Login: $login, senha: $senha");

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;

      print(">>> $user");

      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }

    setState(() {
      _showProgress = false;
    });
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
