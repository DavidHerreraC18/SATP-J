import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';

List<Formulario> formularioFromJson(String str) =>
    List<Formulario>.from(json.decode(str).map((x) => Formulario.fromJson(x)));

String formularioToJson(List<Formulario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Formulario{
    int id;
    Paciente paciente;
    String remitente;
    bool fueAtendido;
    String lugarAtencion;
    String motivoConsulta;

    Formulario({
      this.id,
      this.paciente,
      this.remitente,
      this.fueAtendido,
      this.lugarAtencion,
      this.motivoConsulta
    });

    factory Formulario.fromJson(Map<String, dynamic> json) => Formulario(
        id: json["id"],
        paciente: Paciente.fromJson(json["paciente"]),
        remitente: json["remitente"],
        fueAtendido: json["fueAtendido"],
        lugarAtencion: json["lugarAtencion"]
      );

    Map<String, dynamic> toJson() => {
        "id": id,
        "paciente": paciente.toJson(),
        "remitente": remitente,
        "fueAtendido": fueAtendido,
        "lugarAtencion": lugarAtencion
      };

}