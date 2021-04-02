
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'horario.g.dart';

List<Horario> horarioFromJson(String str) =>
    List<Horario>.from(json.decode(str).map((x) => Horario.fromJson(x)));

String horarioToJson(List<Horario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
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

  factory Horario.fromJson(Map<String, dynamic> json) => _$HorarioFromJson(json);

    Map<String, dynamic> toJson() => _$HorarioToJson(this);
}