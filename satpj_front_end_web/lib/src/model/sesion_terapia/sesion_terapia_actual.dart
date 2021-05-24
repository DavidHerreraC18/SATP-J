import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';

part 'sesion_terapia_actual.g.dart';

List<SesionTerapiaActual> sesionTerapiaActualFromJson(String str) =>
    List<SesionTerapiaActual>.from(
        json.decode(str).map((x) => SesionTerapiaActual.fromJson(x)));

String sesionTerapiaActualToJson(List<SesionTerapiaActual> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

SesionTerapiaActual singleSesionTerapiaActualFromJson(String str) {
  SesionTerapiaActual sesionTerapia =
      SesionTerapiaActual.fromJson(json.decode(str));
  return sesionTerapia;
}

@JsonSerializable(explicitToJson: true)
class SesionTerapiaActual {
  DateTime fecha;
  bool posible;
  SesionTerapia sesionTerapia;

  SesionTerapiaActual({
    this.fecha,
    this.posible,
    this.sesionTerapia,
  });

  factory SesionTerapiaActual.fromJson(Map<String, dynamic> json) =>
      _$SesionTerapiaActualFromJson(json);

  Map<String, dynamic> toJson() => _$SesionTerapiaActualToJson(this);
}
