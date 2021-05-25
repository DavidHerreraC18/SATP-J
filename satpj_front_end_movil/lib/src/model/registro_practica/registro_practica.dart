import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_movil/src/model/practicante/practicante.dart';

part 'registro_practica.g.dart';

List<RegistroPractica> registroPracticaFromJson(String str) =>
    List<RegistroPractica>.from(
        json.decode(str).map((x) => Practicante.fromJson(x)));

String registroPracticaToJson(List<RegistroPractica> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class RegistroPractica {
  int id;

  Practicante practicante;

  double horas;

  int sesionesRealizadas;

  int sesionesCanceladas;

  int sesionesSupervisadas;

  RegistroPractica(
      {this.id,
      this.practicante,
      this.horas,
      this.sesionesRealizadas,
      this.sesionesCanceladas,
      this.sesionesSupervisadas});

  factory RegistroPractica.fromJson(Map<String, dynamic> json) =>
      _$RegistroPracticaFromJson(json);

  Map<String, dynamic> toJson() => _$RegistroPracticaToJson(this);
}
