import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/comprobante_pago.dart';

List<InformePago> informePagoFromJson(String str) =>
    List<InformePago>.from(json.decode(str).map((x) => InformePago.fromJson(x)));

String informePagoToJson(List<InformePago> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InformePago{
  int id;
  List<ComprobantePago> comprobante;
  LocalDateTimeInputElement fechaInicio;
  LocalDateTimeInputElement fechaFin;
  double total;

  InformePago({
    this.id,
    this.comprobante,
    this.fechaInicio,
    this.fechaFin,
    this.total
  });

  factory InformePago.fromJson(Map<String, dynamic> json){ 

    var list = json['comprobante'] as List;
    List<ComprobantePago> lcomprobante = list.map((i) => ComprobantePago.fromJson(i)).toList();

    return InformePago(
        id: json["id"],
        comprobante: lcomprobante,
        fechaInicio: json["fechaInicio"],
        fechaFin: json["fechaFin"],
        total: json["total"],
      );
  }

  Map<String, dynamic> toJson(){

    return {
        "id": id,
        "comprobante": jsonEncode(comprobante),
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
        "total": total,
      };
  }

}