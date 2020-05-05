import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map = new MapController();

  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                //Mover el mapa hacia una ubicación
                map.move(scan.getLatLng(), 15);
              })
        ],
      ),
      body: Center(
        child: _crearFlutterMap(scan),
      ),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10,
      ),
      layers: [_crearMapa(), _crearMarcadores(scan)],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoibm9yYmVydG9wcjE5OTgiLCJhIjoiY2s5dDcxbmt6MWRvazNlbzFzNzExMzJiciJ9.HX8k6Td8aIDL3luZ9UydYQ',
          // 'id': 'mapbox.streets'
          // 'id': 'mapbox.dark'
          // 'id': 'mapbox.light'
          // 'id': 'mapbox.outdoors'
          'id': 'mapbox.$tipoMapa'
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100,
          height: 100,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 120.0,
                  color: Theme.of(context).primaryColor,
                ),
              )),
    ]);
  }

  Widget _crearBotonFlotante(BuildContext context) {
    List<String> lista = ['streets', 'dark', 'light', 'outdoors', 'satellite'];

    return FloatingActionButton(
      onPressed: () {
        if (tipoMapa == 'streets') {
          // tipoMapa = lista[1];
          tipoMapa = 'dark';
        } else if (tipoMapa == 'dark') {
          // tipoMapa = lista[2];
          tipoMapa = 'light';
        } else if (tipoMapa == 'light') {
          // tipoMapa = lista[3];
          tipoMapa = 'outdoors';
        } else if (tipoMapa == 'outdoors') {
          // tipoMapa = lista[4];
          tipoMapa = 'satellite';
        } else {
          // tipoMapa = lista[0];
          tipoMapa = 'dark';
        }
        setState(() {});
      },
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
