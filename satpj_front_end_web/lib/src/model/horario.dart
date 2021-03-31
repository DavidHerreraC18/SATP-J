import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/model/usuario.dart';

List<Horario> horarioFromJson(String str) =>
    List<Horario>.from(json.decode(str).map((x) => Horario.fromJson(x)));

String horarioToJson(List<Horario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Horario{
  int id;
  Usuario usuario;
  String lunes;
  String martes;
  String miercoles;
  String jueves;
  String viernes;
  String sabado;

  Horario({
    this.id,
    this.usuario,
    this.lunes,
    this.martes,
    this.miercoles,
    this.jueves,
    this.viernes,
    this.sabado
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json["id"],
        usuario: Usuario.fromJson(json["usuario"]),
        lunes: json["lunes"],
        martes: json["martes"],
        miercoles: json["miercoles"],
        jueves: json["jueves"],
        viernes: json["viernes"],
        sabado: json["sabado"],
      );

    Map<String, dynamic> toJson(){
      return{
        "id": id,
        "usuario": usuario.toJson(),
        "lunes": lunes,
        "martes": martes,
        "miercoles": miercoles,
        "jueves": jueves,
        "viernes": viernes,
        "sabado": sabado
      };
    }
}