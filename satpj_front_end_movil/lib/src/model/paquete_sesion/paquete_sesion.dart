import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_movil/src/model/comprobante_pago/comprobante_pago.dart';
import 'dart:convert';

import 'package:satpj_front_end_movil/src/model/paciente/paciente.dart';

part 'paquete_sesion.g.dart';

List<PaqueteSesion> paqueteSesionFromJson(String str) =>
    List<PaqueteSesion>.from(
        json.decode(str).map((x) => PaqueteSesion.fromJson(x)));

String paqueteSesionToJson(List<PaqueteSesion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class PaqueteSesion {
  int id;

  Paciente paciente;

  ComprobantePago comprobantePago;

  int cantidadSesiones;

  double total;

  DateTime fecha;

  PaqueteSesion(
      {this.id,
      this.paciente,
      this.comprobantePago,
      this.cantidadSesiones,
      this.total,
      this.fecha});

  factory PaqueteSesion.fromJson(Map<String, dynamic> json) =>
      _$PaqueteSesionFromJson(json);

  Map<String, dynamic> toJson() => _$PaqueteSesionToJson(this);
}
