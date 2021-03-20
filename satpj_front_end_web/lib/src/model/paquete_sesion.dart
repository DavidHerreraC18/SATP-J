import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/comprobante_pago.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';


List<PaqueteSesion> paqueteSesionFromJson(String str) =>
    List<PaqueteSesion>.from(json.decode(str).map((x) => PaqueteSesion.fromJson(x)));

String paqueteSesionToJson(List<PaqueteSesion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaqueteSesion{
  int id;
  Paciente paciente;
  ComprobantePago comprobantePago;
  int cantidadSesiones;
  double total;

  PaqueteSesion({
    this.id,
    this.paciente,
    this.comprobantePago,
    this.cantidadSesiones,
    this.total
  });

  factory PaqueteSesion.fromJson(Map<String, dynamic> json) {

    return PaqueteSesion(
      id: json["id"],
      paciente: Paciente.fromJson(json["paciente"]),
      comprobantePago: ComprobantePago.fromJson(json["comprobantePago"]),
      cantidadSesiones: json["cantidadSesiones"],
      total: json["total"]
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "paciente": paciente.toJson(),
        "comprobantePago": comprobantePago.toJson(),
        "cantidadSesiones": cantidadSesiones,
        "total": total,
      };
}