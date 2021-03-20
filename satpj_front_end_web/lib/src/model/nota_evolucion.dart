import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/llave_nota_evolucion.dart';
import 'package:satpj_front_end_web/src/model/practicante.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/supervisor.dart';

List<NotaEvolucion> notaEvolucionFromJson(String str) =>
    List<NotaEvolucion>.from(json.decode(str).map((x) => NotaEvolucion.fromJson(x)));

String notaEvolucionToJson(List<NotaEvolucion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotaEvolucion{
  LlaveNotaEvolucion id;
  Practicante practicante;
  SesionTerapia sesionTerapia;
  Supervisor supervisor;
  String contenido;
  LocalDateTimeInputElement fechaHora;
  bool enviada;
  bool registrada;

  NotaEvolucion({
    this.id,
    this.practicante,
    this.sesionTerapia,
    this.supervisor,
    this.contenido,
    this.fechaHora,
    this.enviada,
    this.registrada
  });

  factory NotaEvolucion.fromJson(Map<String, dynamic> json) => NotaEvolucion(
        id: json["id"],
        practicante: Practicante.fromJson(json["practicante"]),
        sesionTerapia: SesionTerapia.fromJson(json["sesionTerapia"]),
        supervisor: Supervisor.fromJson(json["supervisor"]),
        contenido: json["contenido"],
        fechaHora: json["fechaHora"],
        enviada: json["enviada"],
        registrada: json["registrada"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "practicante": practicante.toJson(),
        "sesionTerapia": sesionTerapia.toJson(),
        "supervisor": supervisor.toJson(),
        "contenido": contenido,
        "fechaHora": fechaHora,
        "enviada": enviada,
        "registrada": registrada,
      };

}