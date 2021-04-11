
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';

part 'grupo.g.dart';

List<Grupo> grupoFromJson(String str) =>
    List<Grupo>.from(json.decode(str).map((x) => Grupo.fromJson(x)));

String grupoToJson(List<Grupo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class Grupo{

  int id;

  String tipo;
  
  List<Paciente> integrantes;

  Grupo({
    this.id,
    this.tipo,
    this.integrantes
  });

  factory Grupo.fromJson(Map<String, dynamic> json) => _$GrupoFromJson(json);

  Map<String, dynamic> toJson() => _$GrupoToJson(this);

}