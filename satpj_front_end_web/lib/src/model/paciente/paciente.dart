import 'package:intl/intl.dart';
import 'package:satpj_front_end_web/src/model/acudiente/acudiente.dart';
import 'package:satpj_front_end_web/src/model/alerta/alerta_usuario.dart';
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/paciente/fecha_nacimiento.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion/paquete_sesion.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante_paciente.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'paciente.g.dart';

List<Paciente> pacienteFromJson(String str) =>
    List<Paciente>.from(json.decode(str).map((x) => Paciente.fromJson(x)));

String pacienteToJson(List<Paciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Paciente singlePacienteFromJson(String str) {
  Paciente paciente = Paciente.fromJson(json.decode(str));
  return paciente;
}

@JsonSerializable(explicitToJson: true)
class Paciente extends Usuario {
  Supervisor supervisor;

  Grupo grupo;

  //@JsonKey(ignore: true)
  List<PracticantePaciente> practicantesPaciente;

  //@JsonKey(ignore: true)
  List<DocumentoPaciente> documentoPaciente;

  //@JsonKey(ignore: true)
  List<PaqueteSesion> paqueteSesion;

  //@JsonKey(ignore: true)
  List<Acudiente> acudientes;

  //@JsonKey(ignore: true)
  Formulario formulario;

  //@JsonKey(ignore: true)
  FormularioExtra formularioExtra;

  String estadoAprobado;

  int estrato;

  int edad;

  bool remitido;

  Paciente(
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
      this.supervisor,
      this.grupo,
      this.practicantesPaciente,
      this.documentoPaciente,
      this.paqueteSesion,
      this.acudientes,
      this.formulario,
      this.formularioExtra,
      this.estadoAprobado,
      this.estrato,
      this.edad,
      this.remitido})
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

  factory Paciente.fromJson(Map<String, dynamic> json) =>
      _$PacienteFromJson(json);

  Map<String, dynamic> toJson() => _$PacienteToJson(this);

  void definirEdad({String fechaNacimiento = '00-00-0000'}) {
    if (fechaNacimiento != null && fechaNacimiento.isNotEmpty) {
        DateTime birthDate = new DateFormat("yyyy-MM-dd").parse(fechaNacimiento);
        DateTime today = DateTime.now();
        edad =  today.year - birthDate.year;
    }
  }

  bool esAdulto({FechaNacimiento fecha}) {
    if (edad >= 18 ) {
        return true;
    }
    return false;
  }
}
