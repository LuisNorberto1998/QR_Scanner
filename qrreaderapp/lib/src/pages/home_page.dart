import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cargarPage(),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(currentIndex: 0, onTap: (index) {}, items: [
      BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
      BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5), title: Text('Mapas')),
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
