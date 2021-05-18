import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'llave_sesion_usuario.g.dart';

List<LlaveSesionUsuario> llaveSesionUsuarioFromJson(String str) =>
    List<LlaveSesionUsuario>.from(
        json.decode(str).map((x) => LlaveSesionUsuario.fromJson(x)));

String llaveSesionUsuarioToJson(List<LlaveSesionUsuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class LlaveSesionUsuario {
  String usuarioId;
  // ignore: non_constant_identifier_names
  int sesion_terapia_id;

  LlaveSesionUsuario(
      {this.usuarioId,
      // ignore: non_constant_identifier_names
      sesion_terapia_id});

  factory LlaveSesionUsuario.fromJson(Map<String, dynamic> json) =>
      _$LlaveSesionUsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$LlaveSesionUsuarioToJson(this);
}
