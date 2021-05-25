// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerta_usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertaUsuario _$AlertaUsuarioFromJson(Map<String, dynamic> json) {
  return AlertaUsuario(
    id: json['id'] == null
        ? null
        : LlaveAlertaUsuario.fromJson(json['id'] as Map<String, dynamic>),
    alerta: json['alerta'] == null
        ? null
        : Alerta.fromJson(json['alerta'] as Map<String, dynamic>),
    usuario: json['usuario'] == null
        ? null
        : Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
    frecuencia: json['frecuencia'] as int,
  );
}

Map<String, dynamic> _$AlertaUsuarioToJson(AlertaUsuario instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'alerta': instance.alerta?.toJson(),
      'usuario': instance.usuario?.toJson(),
      'frecuencia': instance.frecuencia,
    };
