import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante.dart';

List<RegistroPractica> registroPracticaFromJson(String str) =>
    List<RegistroPractica>.from(
        json.decode(str).map((x) => Practicante.fromJson(x)));

String registroPracticaToJson(List<RegistroPractica> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegistroPractica{
  int id;
  Practicante practicante;
  double horas;
  int sesionesRealizadas;
  int sesionesCanceladas;
  int sesionesSupervisadas;

  RegistroPractica({
    this.id,
    this.practicante,
    this.horas,
    this.sesionesRealizadas,
    this.sesionesCanceladas,
    this.sesionesSupervisadas
  });

  factory RegistroPractica.fromJson(Map<String, dynamic> json) {
    return RegistroPractica(
        id: json["id"],
        practicante: Practicante.fromJson(json["practicante"]),
        horas: json["horas"],
        sesionesRealizadas: json["sesionesRealizadas"],
        sesionesCanceladas: json["sesionesCanceladas"],
        sesionesSupervisadas: json["sesionesSupervisadas"],
        );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "practicante": practicante.toJson(),
        "horas": horas,
        "sesionesRealizadas": sesionesRealizadas,
        "sesionesCanceladas": sesionesCanceladas,
        "sesionesSupervisadas": sesionesSupervisadas,
      };
}