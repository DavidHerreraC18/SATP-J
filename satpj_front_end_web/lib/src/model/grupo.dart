import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';


List<Grupo> grupoFromJson(String str) =>
    List<Grupo>.from(json.decode(str).map((x) => Grupo.fromJson(x)));

String grupoToJson(List<Grupo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Grupo{
  int id;
  String tipo;
  List<Paciente> integrantes;

  Grupo({
    this.id,
    this.tipo,
    this.integrantes
  });

  factory Grupo.fromJson(Map<String, dynamic> json){ 

    var list = json['integrantes'] as List;
    List<Paciente> lintegrantes = list.map((i) => Paciente.fromJson(i)).toList();

    return Grupo(
        id: json["id"],
        tipo: json["tipo"],
        integrantes: lintegrantes,
      );
  }

  Map<String, dynamic> toJson(){

    return {
        "id": id,
        "tipo": tipo,
        "integrantes": jsonEncode(integrantes),
      };
  }

}