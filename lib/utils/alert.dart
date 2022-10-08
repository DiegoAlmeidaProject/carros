
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

alert(BuildContext context, String msg, {Function callback}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          /**Atributo evita que seja fechado o modal pelo Botão do celualar**/
          child: AlertDialog(
            title: Text("Carros"),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  if (callback != null) {
                    callback();
                  }
                },
              )
            ],
          ),
        );
      });
}