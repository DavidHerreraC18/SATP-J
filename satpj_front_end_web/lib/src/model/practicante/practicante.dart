import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_web/src/model/alerta/alerta_usuario.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante_paciente.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'practicante.g.dart';

List<Practicante> practicanteFromJson(String str) => List<Practicante>.from(
    json.decode(str).map((x) => Practicante.fromJson(x)));

String practicanteToJson(List<Practicante> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Practicante singlePracticanteFromJson(String str) {
  Practicante practicante = Practicante.fromJson(json.decode(str));
  return practicante;
}

@JsonSerializable(explicitToJson: true)
class Practicante extends Usuario {
  List<PracticantePaciente> practicante;

  bool pregrado;

  int semestre;

  int aforo;

  String enfoque;

  bool activo;

  Practicante(
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
      this.practicante,
      this.pregrado,
      this.aforo,
      this.semestre,
      this.enfoque,
      this.activo})
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

  factory Practicante.fromJson(Map<String, dynamic> json) =>
      _$PracticanteFromJson(json);

  Map<String, dynamic> toJson() => _$PracticanteToJson(this);
}
