import 'package:satpj_front_end_movil/src/model/nota_evolucion/llave_nota_evolucion.dart';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_movil/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_movil/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_movil/src/model/supervisor/supervisor.dart';

part 'nota_evolucion.g.dart';

List<NotaEvolucion> notaEvolucionFromJson(String str) =>
    List<NotaEvolucion>.from(
        json.decode(str).map((x) => NotaEvolucion.fromJson(x)));

String notaEvolucionToJson(List<NotaEvolucion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class NotaEvolucion {
  LlaveNotaEvolucion id;

  Practicante practicante;

  SesionTerapia sesionTerapia;

  Supervisor supervisor;

  String contenido;

  DateTime fechaHora;

  bool enviada;

  bool registrada;

  NotaEvolucion(
      {this.id,
      this.practicante,
      this.sesionTerapia,
      this.supervisor,
      this.contenido,
      this.fechaHora,
      this.enviada,
      this.registrada});

  factory NotaEvolucion.fromJson(Map<String, dynamic> json) =>
      _$NotaEvolucionFromJson(json);

  Map<String, dynamic> toJson() => _$NotaEvolucionToJson(this);
}
