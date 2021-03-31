import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion.dart';
import 'package:satpj_front_end_web/src/model/sesion_usuario.dart';

List<SesionTerapia> sesionTerapiaFromJson(String str) =>
    List<SesionTerapia>.from(
        json.decode(str).map((x) => SesionTerapia.fromJson(x)));

String sesionTerapiaToJson(List<SesionTerapia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SesionTerapia{
  int id;
  List<SesionUsuario> sesiones;
  PaqueteSesion paqueteSesion;
  LocalDateTimeInputElement fecha;
  LocalDateTimeInputElement hora;
  bool virtual;
  String consultorio;

  SesionTerapia({
    this.id,
    this.sesiones,
    this.paqueteSesion,
    this.fecha,
    this.hora,
    this.virtual,
    this.consultorio
  });

  factory SesionTerapia.fromJson(Map<String, dynamic> json){ 

    var list = json['sesiones'] as List;
    List<SesionUsuario> lsesiones = list.map((i) => SesionUsuario.fromJson(i)).toList();

    return SesionTerapia(
        id: json["id"],
        sesiones: lsesiones,
        paqueteSesion: PaqueteSesion.fromJson(json["paqueteSesion"]),
        fecha: json["fecha"],
        hora: json["hora"],
        virtual: json["virtual"],
        consultorio: json["consultorio"]
      );
  }

  Map<String, dynamic> toJson(){

    return {
        "id": id,
        "sesiones": jsonEncode(sesiones),
        "paqueteSesion": paqueteSesion.toJson(),
        "fecha": fecha,
        "hora": hora,
        "virtual": virtual,
        "consultorio": consultorio,
      };
  }
}