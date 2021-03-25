import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/model/usuario.dart';

List<Supervisor> supervisorFromJson(String str) =>
    List<Supervisor>.from(json.decode(str).map((x) => Supervisor.fromJson(x)));

String supervisorToJson(List<Supervisor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supervisor extends Usuario {
  String enfoque;
  List<Paciente> pacientes;

  Supervisor({this.enfoque, this.pacientes});

  factory Supervisor.fromJson(Map<String, dynamic> json) {
    var list = json['pacientes'] as List;
    List<Paciente> lpacientes = list.map((i) => Paciente.fromJson(i)).toList();

    return Supervisor(
      enfoque: json["enfoque"],
      pacientes: lpacientes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "enfoque": enfoque,
      "pacientes": jsonEncode(pacientes),
    };
  }
}
