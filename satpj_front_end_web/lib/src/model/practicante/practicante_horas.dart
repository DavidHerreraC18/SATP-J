import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'dart:convert';

part 'practicante_horas.g.dart';

List<PracticanteHoras> practicanteHorasFromJson(String str) =>
    List<PracticanteHoras>.from(
        json.decode(str).map((x) => PracticanteHoras.fromJson(x)));

String practicanteHorasToJson(List<PracticanteHoras> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

PracticanteHoras singlePracticanteHorasFromJson(String str) {
  PracticanteHoras practicante = PracticanteHoras.fromJson(json.decode(str));
  return practicante;
}

@JsonSerializable(explicitToJson: true)
class PracticanteHoras {
  Practicante practicante;

  int horas;

  PracticanteHoras({this.practicante, this.horas});

  factory PracticanteHoras.fromJson(Map<String, dynamic> json) =>
      _$PracticanteHorasFromJson(json);

  Map<String, dynamic> toJson() => _$PracticanteHorasToJson(this);
}
