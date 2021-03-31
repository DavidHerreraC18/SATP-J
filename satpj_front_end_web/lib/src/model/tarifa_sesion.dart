import 'dart:convert';

import 'package:flutter/material.dart';

List<TarifaSesion> tarifaSesionFromJson(String str) =>
    List<TarifaSesion>.from(json.decode(str).map((x) => TarifaSesion.fromJson(x)));

String tarifaSesionToJson(List<TarifaSesion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TarifaSesion{
  int id;
  int estrato;
  int tarifa;

  TarifaSesion({
    this.id,
    this.estrato,
    this.tarifa
  });

  factory TarifaSesion.fromJson(Map<String, dynamic> json) => TarifaSesion(
        id: json["id"],
        estrato: json["estrato"],
        tarifa: json["tarifa"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "estrato": estrato,
        "tarifa": tarifa
      };
}
