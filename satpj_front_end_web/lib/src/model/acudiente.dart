import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/model/usuario.dart';
import 'dart:convert';

List<Acudiente> acudienteFromJson(String str) =>
    List<Acudiente>.from(json.decode(str).map((x) => Acudiente.fromJson(x)));

String acudienteToJson(List<Acudiente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Acudiente extends Usuario{
    Paciente paciente;

    Acudiente({
      this.paciente
    });

    factory Acudiente.fromJson(Map<String, dynamic> json) => Acudiente(
        paciente: Paciente.fromJson(json["paciente"]),
      );

  Map<String, dynamic> toJson() => {
        "paciente": paciente.toJson()
      };
}