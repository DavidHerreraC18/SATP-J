import 'dart:convert';

import 'package:flutter/material.dart';

List<LlaveAlertaUsuario> llaveAlertaUsuarioFromJson(String str) =>
    List<LlaveAlertaUsuario>.from(json.decode(str).map((x) => LlaveAlertaUsuario.fromJson(x)));

String llaveAlertaUsuarioToJson(List<LlaveAlertaUsuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LlaveAlertaUsuario{
  int alertaId;
  String usuarioId;

  LlaveAlertaUsuario({
    this.alertaId,
    this.usuarioId
  });

  factory LlaveAlertaUsuario.fromJson(Map<String, dynamic> json) => LlaveAlertaUsuario(
        alertaId: json["alertaId"],
        usuarioId: json["usuarioId"],
      );

  Map<String, dynamic> toJson() => {
        "alertaId": alertaId,
        "usuarioId": usuarioId,
      };

}