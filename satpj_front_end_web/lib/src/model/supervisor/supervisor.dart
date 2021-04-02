
import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_web/src/model/alerta/alerta_usuario.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'supervisor.g.dart';

List<Supervisor> supervisorFromJson(String str) =>
    List<Supervisor>.from(json.decode(str).map((x) => Supervisor.fromJson(x)));

String supervisorToJson(List<Supervisor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class Supervisor extends Usuario {

  String enfoque;
  
  List<Paciente> pacientes;

  Supervisor(
    {
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
      String infoSesion,
      this.enfoque, 
      this.pacientes
    }):super(
            id : id,
            sesiones: sesiones,
            alertasUsuario: alertasUsuario, 
            horarios:horarios,
            documento: documento,
            tipoDocumento : tipoDocumento,
            nombre : nombre,
            apellido : apellido,
            email : email,
            telefono : telefono,
            tipoUsuario : tipoUsuario,
            infoSesion : infoSesion
            );

  factory Supervisor.fromJson(Map<String, dynamic> json) => _$SupervisorFromJson(json);

  Map<String, dynamic> toJson() => _$SupervisorToJson(this);
}
