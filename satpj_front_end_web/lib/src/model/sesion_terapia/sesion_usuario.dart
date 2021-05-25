
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/sesion_terapia/llave_sesion_usuario.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'sesion_usuario.g.dart';

List<SesionUsuario> sesionUsuarioFromJson(String str) =>
    List<SesionUsuario>.from(
        json.decode(str).map((x) => SesionUsuario.fromJson(x)));

String sesionUsuarioToJson(List<SesionUsuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class SesionUsuario{

  LlaveSesionUsuario id;

  Usuario usuario;

  SesionTerapia sesionTerapia;
  
  bool observador;

  SesionUsuario({
    this.id,
    this.usuario,
    this.sesionTerapia,
    this.observador
  });

  factory SesionUsuario.fromJson(Map<String, dynamic> json) => _$SesionUsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$SesionUsuarioToJson(this);

}