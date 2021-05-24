import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_movil/src/model/informe_pago/informe_pago.dart';
import 'dart:convert';

import 'package:satpj_front_end_movil/src/model/paquete_sesion/paquete_sesion.dart';

part 'comprobante_pago.g.dart';

List<ComprobantePago> comprobantePagoFromJson(String str) =>
    List<ComprobantePago>.from(
        json.decode(str).map((x) => ComprobantePago.fromJson(x)));

String comprobantePagoToJson(List<ComprobantePago> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class ComprobantePago {
  int id;

  PaqueteSesion paqueteSesion;

  List<InformePago> informesPagos;

  double valorTotal;

  String referenciaPago;

  DateTime fecha;

  String observacion;

  ComprobantePago(
      {this.id,
      this.paqueteSesion,
      this.informesPagos,
      this.valorTotal,
      this.referenciaPago,
      this.fecha,
      this.observacion});

  factory ComprobantePago.fromJson(Map<String, dynamic> json) =>
      _$ComprobantePagoFromJson(json);

  Map<String, dynamic> toJson() => _$ComprobantePagoToJson(this);
}
