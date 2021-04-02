
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:html';

import 'package:satpj_front_end_web/src/model/comprobante_pago/comprobante_pago.dart';

part 'informe_pago.g.dart';

List<InformePago> informePagoFromJson(String str) =>
    List<InformePago>.from(json.decode(str).map((x) => InformePago.fromJson(x)));

String informePagoToJson(List<InformePago> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class InformePago{

  int id;

  List<ComprobantePago> comprobante;

  DateTime fechaInicio;

  DateTime fechaFin;

  double total;

  InformePago({
    this.id,
    this.comprobante,
    this.fechaInicio,
    this.fechaFin,
    this.total
  });

  factory InformePago.fromJson(Map<String, dynamic> json) => _$InformePagoFromJson(json);

  Map<String, dynamic> toJson() => _$InformePagoToJson(this);

}