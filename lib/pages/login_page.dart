import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

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
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget> [
          Text("Login"),
          TextFormField(),

          SizedBox(
            height: 10,
          ),

          Text("Senha"),
          TextFormField(
            obscureText: true, //TODO: caracteres da senha ficam escondidos.
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            height: 46,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22
                ),
              ),
              onPressed: () {
                //TODO: Evento sera tratado em outra aula.
              },
            ),
          )
        ],
      ),
    );
  }
}
