import 'package:satpj_front_end_web/src/model/alerta.dart';
import 'package:satpj_front_end_web/src/model/llave_alerta_usuario.dart';
import 'package:satpj_front_end_web/src/model/usuario.dart';
import 'dart:convert';

List<AlertaUsuario> alertaUsuarioFromJson(String str) =>
    List<AlertaUsuario>.from(json.decode(str).map((x) => AlertaUsuario.fromJson(x)));

String alertaUsuarioToJson(List<AlertaUsuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlertaUsuario{
  LlaveAlertaUsuario id;
  Alerta alerta;
  Usuario usuario;
  int frecuencia;

  AlertaUsuario({
    this.id,
    this.alerta,
    this.usuario,
    this.frecuencia
  });

  factory AlertaUsuario.fromJson(Map<String, dynamic> json) => AlertaUsuario(
        id: json["id"],
        alerta: Alerta.fromJson(json["alerta"]),
        usuario: Usuario.fromJson(json["usuario"]),
        frecuencia: json["frecuencia"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alerta": alerta.toJson(),
        "usuario": usuario.toJson(),
        "frecuencia": frecuencia,
      };
}