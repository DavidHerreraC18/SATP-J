import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/informe_pago.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion.dart';

List<ComprobantePago> comprobantePagoFromJson(String str) =>
    List<ComprobantePago>.from(json.decode(str).map((x) => ComprobantePago.fromJson(x)));

String comprobantePagoToJson(List<ComprobantePago> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComprobantePago{
  int id;
  PaqueteSesion paqueteSesion;
  List<InformePago> informesPagos;
  double valorTotal;
  String referenciaPago;
  LocalDateTimeInputElement fecha;
  String observacion;

  ComprobantePago({
    this.id,
    this.paqueteSesion,
    this.informesPagos,
    this.valorTotal,
    this.referenciaPago,
    this.fecha,
    this.observacion
  });

  factory ComprobantePago.fromJson(Map<String, dynamic> json){ 

    var list = json['informesPagos'] as List;
    List<InformePago> linformesPagos = list.map((i) => InformePago.fromJson(i)).toList();

    return ComprobantePago(
        id: json["id"],
        paqueteSesion: PaqueteSesion.fromJson(json["paqueteSesion"]),
        informesPagos: linformesPagos,
        valorTotal: json["valorTotal"],
        referenciaPago: json["referenciaPago"],
        fecha: json["fecha"],
        observacion: json["observacion"]
      );
  }

  Map<String, dynamic> toJson(){

    return {
        "id": id,
        "paqueteSesion": paqueteSesion.toJson(),
        "informesPagos": jsonEncode(informesPagos),
        "valorTotal": valorTotal,
        "referenciaPago": referenciaPago,
        "fecha": fecha,
        "observacion": observacion
      };
  }
}