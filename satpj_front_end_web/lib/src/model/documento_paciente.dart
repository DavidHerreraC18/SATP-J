import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';

List<DocumentoPaciente> documentoPacienteFromJson(String str) =>
    List<DocumentoPaciente>.from(json.decode(str).map((x) => DocumentoPaciente.fromJson(x)));

String documentoPacienteToJson(List<DocumentoPaciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DocumentoPaciente{
  int id;
  Paciente paciente;
  String nombre;
  Blob contenido;
  String tipo;
  LocalDateTimeInputElement radicacion;
  LocalDateTimeInputElement vencimiento;

  DocumentoPaciente({
    this.id,
    this.paciente,
    this.nombre,
    this.contenido,
    this.tipo,
    this.radicacion,
    this.vencimiento
  });

  factory DocumentoPaciente.fromJson(Map<String, dynamic> json) => DocumentoPaciente(
        id: json["id"],
        paciente: Paciente.fromJson(json["paciente"]),
        nombre: json["nombre"],
        contenido: json["contenido"],
        tipo: json["tipo"],
        radicacion: json["radicacion"],
        vencimiento: json["vencimiento"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paciente": paciente.toJson(),
        "nombre": nombre,
        "contenido": contenido,
        "tipo": tipo,
        "radicacion": radicacion,
        "vencimiento": vencimiento,
      };
}