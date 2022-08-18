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
            _text("Login", "Digite o login",
                controller: _tlogin,
                validator: _validateLogin,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                nextFocus: _focussenha),
            SizedBox(
              height: 10,
            ),
            _text("Senha", "Digite a senha",
                password: true,
                controller: _tSenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focussenha),
            SizedBox(
              height: 20,
            ),
            _button("Login", _onClickLogin),
          ],
        ),
      ),
    );
  }

  _text(
    String label,
    String hint, {
    bool password = false,
    controller,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    FocusNode? nextFocus,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 25,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 25,
          color: Colors.grey,
        ),
        hintText: hint,
        helperStyle: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  _button(String text, VoidCallback onPressed) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  _onClickLogin() {
    bool? formaOk = _formKey.currentState?.validate();
    if (!formaOk!) {
      return;
    }

    String login = _tlogin.text;
    String senha = _tSenha.text;

    print("Login: $login, senha: $senha");
  }

  String? _validateLogin(String? text) {
    if (text!.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  String? _validateSenha(String? text) {
    if (text!.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }
}
