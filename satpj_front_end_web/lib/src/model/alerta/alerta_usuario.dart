import 'package:satpj_front_end_web/src/model/alerta/alerta.dart';
import 'package:satpj_front_end_web/src/model/alerta/llave_alerta_usuario.dart';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'alerta_usuario.g.dart';

List<AlertaUsuario> alertaUsuarioFromJson(String str) =>
    List<AlertaUsuario>.from(
        json.decode(str).map((x) => AlertaUsuario.fromJson(x)));

String alertaUsuarioToJson(List<AlertaUsuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class AlertaUsuario {
  LlaveAlertaUsuario id;

  Alerta alerta;

  Usuario usuario;

  int frecuencia;

  AlertaUsuario({this.id, this.alerta, this.usuario, this.frecuencia});

  factory AlertaUsuario.fromJson(Map<String, dynamic> json) =>
      _$AlertaUsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$AlertaUsuarioToJson(this);
}
