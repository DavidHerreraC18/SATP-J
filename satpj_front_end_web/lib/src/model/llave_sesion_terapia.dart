import 'dart:convert';

import 'package:flutter/material.dart';

List<LlaveSesionUsuario> llaveSesionUsuarioFromJson(String str) =>
    List<LlaveSesionUsuario>.from(json.decode(str).map((x) => LlaveSesionUsuario.fromJson(x)));

String llaveSesionUsuarioToJson(List<LlaveSesionUsuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LlaveSesionUsuario{
  String usuarioId;
  int sesionTerapiaId;

  LlaveSesionUsuario({
    this.usuarioId,
    this.sesionTerapiaId
  });

  factory LlaveSesionUsuario.fromJson(Map<String, dynamic> json) => LlaveSesionUsuario(
        usuarioId: json["usuarioId"],
        sesionTerapiaId: json["sesionTerapiaId"],
      );

  Map<String, dynamic> toJson() => {
        "usuarioId": usuarioId,
        "sesionTerapiaId": sesionTerapiaId,
      };


}