import 'dart:convert';

import 'package:flutter/material.dart';

List<LlaveNotaEvolucion> llaveNotaEvolucionFromJson(String str) =>
    List<LlaveNotaEvolucion>.from(json.decode(str).map((x) => LlaveNotaEvolucion.fromJson(x)));

String llaveNotaEvolucionToJson(List<LlaveNotaEvolucion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LlaveNotaEvolucion{
  String practicanteId;
  int sesionTerapiaId;

  LlaveNotaEvolucion({
    this.practicanteId,
    this.sesionTerapiaId
  });

  factory LlaveNotaEvolucion.fromJson(Map<String, dynamic> json) => LlaveNotaEvolucion(
        practicanteId: json["practicanteId"],
        sesionTerapiaId: json["sesionTerapiaId"],
      );

  Map<String, dynamic> toJson() => {
        "practicanteId": practicanteId,
        "sesionTerapiaId": sesionTerapiaId,
      };
}