import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carros_api.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/nav.dart';

class CarroFormPage extends StatefulWidget {
  final Carro carro;

  CarroFormPage({this.carro});

  @override
  State<StatefulWidget> createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  File _file;

  Carro get carro => widget.carro;

  // Add validate email function.
  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do carro.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (carro != null) {
      tNome.text = carro.nome;
      tDesc.text = carro.desc;
      _radioIndex = getTipoInt(carro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carro != null ? carro.nome : "Novo Carro",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          Text(
            "Clique na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Tipo",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioTipo(),
          Divider(),
          AppText(
            "nome",
            "",
            controller: tNome,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          AppText(
            "descri????o",
            "",
            controller: tDesc,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          AppButton(
              "Salvar",
              onPressed: _onClickSalvar,
            showProgress: _showProgress,
          ),
        ],
      ),
    );
  }

  //TODO : metodo de valida????o de imagem url x local
  _headerFoto() {
    return InkWell(
      onTap: _onClickFoto,
      child: _file != null
          ? Image.file(_file, height: 150,) :
      carro != null
          ? CachedNetworkImage(
        imageUrl: carro.urlFoto ??
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Renault_Megane_Trophy.png",
        height: 150,
      )
          : Image.asset(
        "assets/images/camera.png",
        height: 150,
      ),
    );
  }

  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Cl??ssicos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Esportivos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Luxo",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTipoInt(Carro carro) {
    switch (carro.tipo) {
      case "classicos":
        return 0;
      case "esportivos":
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return "classicos";
      case 1:
        return "esportivos";
      default:
        return "luxo";
    }
  }

  void _onClickFoto() async {
    try {
      final _image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (_image == null ) return;

      final imageTemp = File(_image.path);
      //print('3 imageTemp $imageTemp');

      setState(() => this._file = imageTemp);
      //print('SETSTATE $imageTemp');
    } catch (e) {
      print('object $e');
    }
  }

  
  _onClickSalvar() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Cria o carro
    var c = carro ?? Carro();
    c.nome = tNome.text;
    c.desc = tDesc.text;
    c.tipo = _getTipo();

    print("Carro: $c");

    setState(() {
      _showProgress = true;
    });

    print("Salvar o carro $c");

    ApiResponse<bool> response = await CarrosApi.save(c, _file);

    if (response.ok) {
      alert(context, "Carro salvo com sucesso", "", callback: (){
        pop(context);
      });
    } else {
      alert(context, response.msg, "");
    }

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _showProgress = false;
    });

    print("Fim.");
  }
  
}
