import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante_paciente.dart';
import 'package:satpj_front_end_web/src/model/usuario.dart';

List<Practicante> practicanteFromJson(String str) =>
    List<Practicante>.from(
        json.decode(str).map((x) => Practicante.fromJson(x)));

String practicanteToJson(List<Practicante> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Practicante extends Usuario{
  List<PracticantePaciente> practicante;
  bool pregrado;
  int semestre;
  String enfoque;
  bool activo;

  Practicante({
    this.practicante,
    this.pregrado,
    this.semestre,
    this.enfoque,
    this.activo
  });

  factory Practicante.fromJson(Map<String, dynamic> json){ 

    var list = json['practicante'] as List;
    List<PracticantePaciente> lpracticante = list.map((i) => PracticantePaciente.fromJson(i)).toList();

    return Practicante(
        practicante: lpracticante,
        pregrado: json["pregrado"],
        semestre: json["semestre"],
        enfoque: json["enfoque"],
        activo: json["activo"]
      );
  }

  Map<String, dynamic> toJson(){

    return {
        "practicante": jsonEncode(practicante),
        "pregrado": pregrado,
        "semestre": semestre,
        "enfoque": enfoque,
        "activo": activo
      };
  }
}