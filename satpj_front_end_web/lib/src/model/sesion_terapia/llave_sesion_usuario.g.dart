// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llave_sesion_usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LlaveSesionUsuario _$LlaveSesionUsuarioFromJson(Map<String, dynamic> json) {
  return LlaveSesionUsuario(
    usuarioId: json['usuarioId'] as String,
    sesionTerapiaId: json['sesionTerapiaId'] as int,
  );
}

Map<String, dynamic> _$LlaveSesionUsuarioToJson(LlaveSesionUsuario instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'sesionTerapiaId': instance.sesionTerapiaId,
    };
