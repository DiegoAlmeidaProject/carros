import 'package:carros/pages/login/login_page.dart';
import 'package:carros/splashpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //TODO: Retira o banner.
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, //TODO: Tema padrão, podemos utilizar o DARK também.
        scaffoldBackgroundColor: Colors.white //TODO: Define a cor de fundo do container do scaffold
      ),
      home: SplashPage(),
    );
  }
}
