import 'package:satpj_front_end_web/src/model/acudiente.dart';
import 'package:satpj_front_end_web/src/model/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/formulario.dart';
import 'package:satpj_front_end_web/src/model/grupo.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion.dart';
import 'package:satpj_front_end_web/src/model/practicante.dart';
import 'package:satpj_front_end_web/src/model/practicante_paciente.dart';
import 'package:satpj_front_end_web/src/model/supervisor.dart';
import 'package:satpj_front_end_web/src/model/usuario.dart';
import 'dart:convert';

List<Paciente> pacienteFromJson(String str) =>
    List<Paciente>.from(json.decode(str).map((x) => Paciente.fromJson(x)));

String pacienteToJson(List<Paciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Paciente extends Usuario {
  Supervisor supervisor;
  Grupo grupo;
  List<PracticantePaciente> practicantesPaciente;
  List<DocumentoPaciente> documentoPaciente;
  List<PaqueteSesion> paqueteSesion;
  List<Acudiente> acudientes;
  Formulario formulario;
  String estadoAprobado;
  int estrato;
  int edad;
  bool remitido;

  Paciente(
      {this.supervisor,
      this.grupo,
      this.practicantesPaciente,
      this.documentoPaciente,
      this.paqueteSesion,
      this.acudientes,
      this.formulario,
      this.estadoAprobado,
      this.estrato,
      this.edad,
      this.remitido});

  factory Paciente.fromJson(Map<String, dynamic> json) {
    var list1 = json['practicantesPaciente'] as List;
    List<PracticantePaciente> lpracticantesPaciente = list1.map((i) => PracticantePaciente.fromJson(i)).toList();
    var list2 = json['documentoPaciente'] as List;
    List<DocumentoPaciente> ldocumentoPaciente = list2.map((i) => DocumentoPaciente.fromJson(i)).toList();
    var list3 = json['paqueteSesion'] as List;
    List<PaqueteSesion> lpaqueteSesion = list3.map((i) => PaqueteSesion.fromJson(i)).toList();
    var list4 = json['acudientes'] as List;
    List<Acudiente> lacudientes = list4.map((i) => Acudiente.fromJson(i)).toList();

    return Paciente(
      supervisor: Supervisor.fromJson(json["supervisor"]),
      grupo: Grupo.fromJson(json["grupo"]),
      practicantesPaciente: lpracticantesPaciente,
      documentoPaciente: ldocumentoPaciente,
      paqueteSesion: lpaqueteSesion,
      acudientes: lacudientes,
      formulario: Formulario.fromJson(json["formulario"]),
      estadoAprobado: json["estadoAprobado"],
      estrato: json["estrato"],
      edad: json["edad"],
      remitido: json["remitido"],
    );
  }

  Map<String, dynamic> toJson() => {
        "supervisor": supervisor.toJson(),
        "grupo": grupo.toJson(),
        "practicantesPaciente": jsonEncode(practicantesPaciente),
        "documentoPaciente": jsonEncode(documentoPaciente),
        "paqueteSesion": jsonEncode(paqueteSesion),
        "acudientes": jsonEncode(acudientes),
        "formulario": formulario.toJson(),
        "estadoAprobado": estadoAprobado,
        "estrato": estrato,
        "edad": edad,
        "remitido": remitido
      };
}
