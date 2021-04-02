import 'package:satpj_front_end_web/src/model/alerta/alerta_usuario.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'acudiente.g.dart';

List<Acudiente> acudienteFromJson(String str) =>
    List<Acudiente>.from(json.decode(str).map((x) => Acudiente.fromJson(x)));

String acudienteToJson(List<Acudiente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class Acudiente extends Usuario {
  Paciente paciente;

  Acudiente(
      {String id,
      List<SesionUsuario> sesiones,
      List<AlertaUsuario> alertasUsuario,
      List<Horario> horarios,
      String documento,
      String tipoDocumento,
      String nombre,
      String apellido,
      String email,
      String telefono,
      String tipoUsuario,
      String direccion,
      String infoSesion,
      this.paciente})
      : super(
            id: id,
            sesiones: sesiones,
            alertasUsuario: alertasUsuario,
            horarios: horarios,
            documento: documento,
            tipoDocumento: tipoDocumento,
            nombre: nombre,
            apellido: apellido,
            email: email,
            telefono: telefono,
            tipoUsuario: tipoUsuario,
            direccion: direccion,
            infoSesion: infoSesion);

  factory Acudiente.fromJson(Map<String, dynamic> json) =>
      _$AcudienteFromJson(json);

  Map<String, dynamic> toJson() => _$AcudienteToJson(this);
}
