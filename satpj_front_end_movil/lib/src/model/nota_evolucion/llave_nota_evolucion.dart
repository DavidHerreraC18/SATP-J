import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'llave_nota_evolucion.g.dart';

List<LlaveNotaEvolucion> llaveNotaEvolucionFromJson(String str) =>
    List<LlaveNotaEvolucion>.from(json.decode(str).map((x) => LlaveNotaEvolucion.fromJson(x)));

String llaveNotaEvolucionToJson(List<LlaveNotaEvolucion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class LlaveNotaEvolucion{
  String practicanteId;
  int sesionTerapiaId;

  LlaveNotaEvolucion({
    this.practicanteId,
    this.sesionTerapiaId
  });

  factory LlaveNotaEvolucion.fromJson(Map<String, dynamic> json) => _$LlaveNotaEvolucionFromJson(json);

  Map<String, dynamic> toJson() => _$LlaveNotaEvolucionToJson(this);
}