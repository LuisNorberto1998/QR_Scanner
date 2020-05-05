import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    //Si el valor tiene HTTP se asigna el tipo
    if (valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  //Crear nueva instancia de ScanModel u otra cosa
  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  //Retornar objeto del mismo tipo
  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };

  //Obtener Latitud y Logngitu
  LatLng getLatLng() {
    final latlong = valor.substring(4).split(',');
    final latitud = double.parse(latlong[0]);
    final longitud = double.parse(latlong[1]);
    print(longitud);
    print(latitud);
    return LatLng(latitud, longitud);
  }
}
