import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'llave_alerta_usuario.g.dart';


List<LlaveAlertaUsuario> llaveAlertaUsuarioFromJson(String str) =>
    List<LlaveAlertaUsuario>.from(json.decode(str).map((x) => LlaveAlertaUsuario.fromJson(x)));

String llaveAlertaUsuarioToJson(List<LlaveAlertaUsuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class LlaveAlertaUsuario{
  int alertaId;
  String usuarioId;

  LlaveAlertaUsuario({
    this.alertaId,
    this.usuarioId
  });

  factory LlaveAlertaUsuario.fromJson(Map<String, dynamic> json) => _$LlaveAlertaUsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$LlaveAlertaUsuarioToJson(this);

}