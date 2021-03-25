import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/alerta_usuario.dart';

List<Alerta> alertaFromJson(String str) =>
    List<Alerta>.from(json.decode(str).map((x) => Alerta.fromJson(x)));

String alertaToJson(List<Alerta> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Alerta{
  int id;
  List<AlertaUsuario> alertaUsuario;
  String tipo;

  Alerta({
    this.id,
    this.alertaUsuario,
    this.tipo
  });

  factory Alerta.fromJson(Map<String, dynamic> json){ 

    var list = json['alertaUsuario'] as List;
    List<AlertaUsuario> alertasUsuario = list.map((i) => AlertaUsuario.fromJson(i)).toList();

    return Alerta(
        id: json["id"],
        alertaUsuario: alertasUsuario,
        tipo: json["tipo"],
      );
  }

  Map<String, dynamic> toJson(){

    return {
        "id": id,
        "alertaUsuario": jsonEncode(alertaUsuario),
        "tipo": tipo,
      };
  }

}