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
        onPressed: _scanQR,
        child: Icon(Icons.filter_center_focus),
      ),
    );
  }

  void _scanQR() async {
    //https://turispotweb.herokuapp.com/
    //geo: 40.73255860802501, -73.89333143671877

    // dynamic futurestring = 'https://turispotweb.herokuapp.com/';
    dynamic futurestring = 'https://www.google.com/';

    // try {
    //   futurestring = await BarcodeScanner.scan();
    // } catch (e) {
    //   futurestring = e.toString();
    // }

    if (futurestring != null) {
      //Grabar la información del escaneo
      final scan = ScanModel(valor: futurestring);
      scansBloc.agregarScan(scan);
      if (Platform.isIOS || Platform.isAndroid) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(scan);
        });
      } else {
        utils.abrirScan(scan);
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
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
