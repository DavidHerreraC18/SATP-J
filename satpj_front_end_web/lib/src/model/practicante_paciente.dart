import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/llave_practicante_paciente.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante.dart';

List<PracticantePaciente> practicantePacienteFromJson(String str) =>
    List<PracticantePaciente>.from(
        json.decode(str).map((x) => PracticantePaciente.fromJson(x)));

String practicantePacienteToJson(List<PracticantePaciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PracticantePaciente {
  LlavePracticantePaciente id;
  Practicante practicante;
  Paciente paciente;
  bool activo;

  PracticantePaciente({this.id, this.practicante, this.paciente, this.activo});

  factory PracticantePaciente.fromJson(Map<String, dynamic> json) {
    return PracticantePaciente(
        id: LlavePracticantePaciente.fromJson(json["id"]),
        practicante: Practicante.fromJson(json["practicante"]),
        paciente: Paciente.fromJson(json["paciente"]),
        activo: json["activo"],
        );
  }

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "practicante": practicante.toJson(),
        "paciente": paciente.toJson(),
        "activo": activo,
      };
}
