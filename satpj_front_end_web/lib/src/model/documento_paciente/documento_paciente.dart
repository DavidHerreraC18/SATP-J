
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';

part 'documento_paciente.g.dart';

List<DocumentoPaciente> documentoPacienteFromJson(String str) =>
    List<DocumentoPaciente>.from(json.decode(str).map((x) => DocumentoPaciente.fromJson(x)));

String documentoPacienteToJson(List<DocumentoPaciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class DocumentoPaciente{

  int id;

  Paciente paciente;

  String nombre;

  String contenido;

  String tipo;

  DateTime radicacion;

  DateTime vencimiento;

  DocumentoPaciente({
    this.id,
    this.paciente,
    this.nombre,
    this.contenido,
    this.tipo,
    this.radicacion,
    this.vencimiento
  });

  factory DocumentoPaciente.fromJson(Map<String, dynamic> json) => _$DocumentoPacienteFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentoPacienteToJson(this);
}