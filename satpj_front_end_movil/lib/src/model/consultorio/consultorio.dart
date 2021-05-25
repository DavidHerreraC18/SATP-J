import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'consultorio.g.dart';

List<Consultorio> consultorioFromJson(String str) => List<Consultorio>.from(
    json.decode(str).map((x) => Consultorio.fromJson(x)));

String consultorioToJson(List<Consultorio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class Consultorio {
  String consultorio;

  Consultorio({this.consultorio});

  factory Consultorio.fromJson(Map<String, dynamic> json) =>
      _$ConsultorioFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultorioToJson(this);
}
