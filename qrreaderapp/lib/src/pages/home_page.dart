import 'dart:io';

import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';

import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScansTodos,
          )
        ],
      ),
      body: _cargarPage(currentindex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _scanQR(context),
        child: Icon(Icons.filter_center_focus),
      ),
    );
  }

  void _scanQR(BuildContext context) async {
    dynamic futureString;

    try {
      // futureString = await new QRCodeReader().scan();
      futureString = await BarcodeScanner.scan();
    } catch(e) {
      futureString = e.toString();
    }

    if ( futureString != null ) {
      
      final scan = ScanModel( valor: futureString.rawContent);
      scansBloc.agregarScan(scan);      

      if ( Platform.isIOS ) {
        Future.delayed( Duration( milliseconds: 750 ), () {
          utils.abrirScan(scan, context);    
        });
      } else {
        utils.abrirScan(scan, context);
      }
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
          BottomNavigationBarItem(
              icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
        ]);
  }

  Widget _cargarPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DirecionesPage();
      default:
        return MapasPage();
    }
  }
}
