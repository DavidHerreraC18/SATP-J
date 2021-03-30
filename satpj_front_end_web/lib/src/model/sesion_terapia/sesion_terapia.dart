
import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion/paquete_sesion.dart';
import 'dart:convert';
import 'dart:html';

import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';

part 'sesion_terapia.g.dart';

List<SesionTerapia> sesionTerapiaFromJson(String str) =>
    List<SesionTerapia>.from(
        json.decode(str).map((x) => SesionTerapia.fromJson(x)));

String sesionTerapiaToJson(List<SesionTerapia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class SesionTerapia{

  int id;

  List<SesionUsuario> sesiones;

  PaqueteSesion paqueteSesion;

  DateTime fecha;

  DateTime hora;

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

  factory SesionTerapia.fromJson(Map<String, dynamic> json) => _$SesionTerapiaFromJson(json);

  Map<String, dynamic> toJson() => _$SesionTerapiaToJson(this);
}