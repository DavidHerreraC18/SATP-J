import 'dart:convert';

import 'package:flutter/material.dart';


List<LlavePracticantePaciente> llavePracticantePacienteFromJson(String str) =>
    List<LlavePracticantePaciente>.from(json.decode(str).map((x) => LlavePracticantePaciente.fromJson(x)));

String llavePracticantePacienteToJson(List<LlavePracticantePaciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LlavePracticantePaciente{
  String pPracticanteId;
  String pPacienteId;

  LlavePracticantePaciente({
    this.pPracticanteId,
    this.pPacienteId
  });

  factory LlavePracticantePaciente.fromJson(Map<String, dynamic> json) => LlavePracticantePaciente(
        pPracticanteId: json["pPracticanteId"],
        pPacienteId: json["pPacienteId"],
      );

  Map<String, dynamic> toJson() => {
        "pPracticanteId": pPracticanteId,
        "pPacienteId": pPacienteId,
      };

}