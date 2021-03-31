import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/llave_sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/usuario.dart';

List<SesionUsuario> sesionUsuarioFromJson(String str) =>
    List<SesionUsuario>.from(
        json.decode(str).map((x) => SesionUsuario.fromJson(x)));

String sesionUsuarioToJson(List<SesionUsuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SesionUsuario{
  LlaveSesionUsuario id;
  Usuario usuario;
  SesionTerapia sesionTerapia;
  bool observador;

  SesionUsuario({
    this.id,
    this.usuario,
    this.sesionTerapia,
    this.observador
  });

  factory SesionUsuario.fromJson(Map<String, dynamic> json) {
    return SesionUsuario(
        id: LlaveSesionUsuario.fromJson(json["id"]),
        usuario: Usuario.fromJson(json["usuario"]),
        sesionTerapia: SesionTerapia.fromJson(json["sesionTerapia"]),
        observador: json["observador"],
        );
  }

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "usuario": usuario.toJson(),
        "sesionTerapia": sesionTerapia.toJson(),
        "observador": observador,
      };

}