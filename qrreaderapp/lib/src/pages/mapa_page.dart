import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:latlong/latlong.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.my_location), onPressed: () {})
        ],
      ),
      body: Center(
        child: _crearFlutterMap(scan),
      ),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10,
      ),
      layers: [_crearMapa()],
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
          'id': 'mapbox.satellite'
        });
  }
}
