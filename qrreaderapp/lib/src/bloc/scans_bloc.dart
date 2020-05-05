import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }
  ScansBloc._internal() {
    //Obtener los scans de la bd
    obtenerScans();
  }

  //Se escuchara en varios lugares el broadcast
  //ScanModel de DBProvider para evitar doble importación
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream =>
      _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamhttp =>
      _scansController.stream.transform(validarHttp);

  //Cerrar el Stream
  dispose() {
    _scansController?.close();
  }

  /*Metodos para controlar el flujo de información */

  /*Obtener toda la información de los Scans */
  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  //Agregar Scan
  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  //Borrar registro por id
  borrarScans(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  //Borrar todos los registros
  borrarScansTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }
}
