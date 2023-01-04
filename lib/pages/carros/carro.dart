import 'dart:convert' as convert;
import 'dart:convert';

import 'package:carros/utils/sql/entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Carro extends Entity {
  int id;
  String nome;
  String tipo;
  String desc;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  latlng() {
    return LatLng(
    latitude == null || latitude.isEmpty ? 0.0 : double.parse(latitude),
    longitude == null || longitude.isEmpty ? 0.0 : double.parse(longitude)
    );
  }

  Carro(
      {this.id,
        this.nome,
        this.tipo,
        this.desc,
        this.urlFoto,
        this.urlVideo,
        this.latitude,
        this.longitude});

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(
    id: json['id'] as int,
    nome: json['nome'] as String,
    tipo: json['tipo'] as String,
    desc: json['desc'] as String,
    urlFoto: json['urlFoto'] as String,
    urlVideo: json['urlVideo'] as String,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;
    data['desc'] = this.desc;
    data['urlFoto'] = this.urlFoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Carro{id: $id, nome: $nome, tipo: $tipo, desc: $desc, urlFoto: $urlFoto, urlVideo: $urlVideo, latitude: $latitude, longitude: $longitude}';
  }


}