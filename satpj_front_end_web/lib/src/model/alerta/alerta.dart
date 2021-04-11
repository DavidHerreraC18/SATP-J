import 'package:satpj_front_end_web/src/model/alerta/alerta_usuario.dart';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'alerta.g.dart';

List<Alerta> alertaFromJson(String str) =>
    List<Alerta>.from(json.decode(str).map((x) => Alerta.fromJson(x)));

String alertaToJson(List<Alerta> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class Alerta{
  
  int id;
  
  List<AlertaUsuario> alertaUsuario;

  String tipo;

  Alerta({
    this.id,
    this.alertaUsuario,
    this.tipo
  });

  factory Alerta.fromJson(Map<String, dynamic> json) => _$AlertaFromJson(json);

  Map<String, dynamic> toJson() => _$AlertaToJson(this);

}