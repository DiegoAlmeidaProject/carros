import 'package:carros/pages/carros/carro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  //Pagina sem estado
  final Carro carro;

  MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: latLng(),
          zoom: 17
        ),
        markers: Set.of(_getMarkers()),
      ),
    );
  }

  latLng() {
    return carro.latlng();
    //return LatLng(-22.951916, -43.2126759);
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
        markerId: MarkerId("1"),
        position: carro.latlng(),
        infoWindow: InfoWindow(
          title: carro.nome,
          snippet: "Fábrica da ${carro.nome}",
          onTap: () {
            print("Clicou na janela");
          }
        ),
        onTap: () {
          print("Clicou no marcador");
        },
      ),
    ];
  }
}
