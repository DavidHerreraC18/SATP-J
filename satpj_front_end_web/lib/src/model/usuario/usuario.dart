import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_web/src/model/alerta/alerta_usuario.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';

part 'usuario.g.dart';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Usuario singleUsuarioFromJson(String str) {
  print("ENTRA A LA FUNCION");
  final mapa = json.decode(str);
  print("hace el decode");
  Usuario usr = Usuario.fromJson(mapa);
  print("NO MURIO");
  print(usr.id);
  return usr;
}

@JsonSerializable(explicitToJson: true)
class Usuario {
  String id;

  List<SesionUsuario> sesiones;

  List<AlertaUsuario> alertasUsuario;

  List<Horario> horarios;

  String documento;

  String tipoDocumento;

  String nombre;

  String apellido;

  String email;

  String telefono;

  String tipoUsuario;

  String direccion;

  String infoSesion;

  Usuario(
      {this.id,
      this.sesiones,
      this.alertasUsuario,
      this.horarios,
      this.documento,
      this.tipoDocumento,
      this.nombre,
      this.apellido,
      this.email,
      this.telefono,
      this.tipoUsuario,
      this.direccion,
      this.infoSesion});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
