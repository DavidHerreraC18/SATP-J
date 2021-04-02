import 'package:satpj_front_end_web/src/model/alerta/alerta_usuario.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'auxiliar_administrativo.g.dart';

List<AuxiliarAdministrativo> auxiliarAdministrativoFromJson(String str) =>
    List<AuxiliarAdministrativo>.from(
        json.decode(str).map((x) => AuxiliarAdministrativo.fromJson(x)));

String auxiliarAdministrativoToJson(List<AuxiliarAdministrativo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class AuxiliarAdministrativo extends Usuario {
  AuxiliarAdministrativo({
    String id,
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
  }) : super(
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

  factory AuxiliarAdministrativo.fromJson(Map<String, dynamic> json) =>
      _$AuxiliarAdministrativoFromJson(json);

  Map<String, dynamic> toJson() => _$AuxiliarAdministrativoToJson(this);
}
