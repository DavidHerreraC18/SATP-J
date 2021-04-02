// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llave_alerta_usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LlaveAlertaUsuario _$LlaveAlertaUsuarioFromJson(Map<String, dynamic> json) {
  return LlaveAlertaUsuario(
    alertaId: json['alertaId'] as int,
    usuarioId: json['usuarioId'] as String,
  );
}

Map<String, dynamic> _$LlaveAlertaUsuarioToJson(LlaveAlertaUsuario instance) =>
    <String, dynamic>{
      'alertaId': instance.alertaId,
      'usuarioId': instance.usuarioId,
    };
