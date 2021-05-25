// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesion_usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SesionUsuario _$SesionUsuarioFromJson(Map<String, dynamic> json) {
  return SesionUsuario(
    id: json['id'] == null
        ? null
        : LlaveSesionUsuario.fromJson(json['id'] as Map<String, dynamic>),
    usuario: json['usuario'] == null
        ? null
        : Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
    sesionTerapia: json['sesionTerapia'] == null
        ? null
        : SesionTerapia.fromJson(json['sesionTerapia'] as Map<String, dynamic>),
    observador: json['observador'] as bool,
  );
}

Map<String, dynamic> _$SesionUsuarioToJson(SesionUsuario instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'usuario': instance.usuario?.toJson(),
      'sesionTerapia': instance.sesionTerapia?.toJson(),
      'observador': instance.observador,
    };
