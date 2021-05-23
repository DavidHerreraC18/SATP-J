import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'tarifa_sesion.g.dart';

List<TarifaSesion> tarifaSesionFromJson(String str) =>
    List<TarifaSesion>.from(json.decode(str).map((x) => TarifaSesion.fromJson(x)));

String tarifaSesionToJson(List<TarifaSesion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class TarifaSesion{

  int id;

  int estrato;
  
  int tarifa;

  TarifaSesion({
    this.id,
    this.estrato,
    this.tarifa
  });

  factory TarifaSesion.fromJson(Map<String, dynamic> json) => _$TarifaSesionFromJson(json);

  Map<String, dynamic> toJson() => _$TarifaSesionToJson(this);
}
