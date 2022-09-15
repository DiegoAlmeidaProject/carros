import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/pages/login_api.dart';
import 'package:carros/pages/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tlogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focussenha = FocusNode();

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
            AppButton("Login",
            onPressed: _onClickLogin,),
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

    ApiResponse response = await LoginApi.login(login, senha);
    if (response.ok) {

      Usuario user = response.result;

      print(">>> $user");

      push(context, HomePage());
    } else {
      print(response.msg);
    }
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
}
