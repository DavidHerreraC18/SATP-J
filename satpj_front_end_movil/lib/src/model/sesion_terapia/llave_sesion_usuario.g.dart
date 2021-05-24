// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llave_sesion_usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LlaveSesionUsuario _$LlaveSesionUsuarioFromJson(Map<String, dynamic> json) {
  return LlaveSesionUsuario(
    usuarioId: json['usuarioId'] as String,
    sesion_terapia_id: json['sesion_terapia_id'] as int,
  );
}

Map<String, dynamic> _$LlaveSesionUsuarioToJson(LlaveSesionUsuario instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'sesion_terapia_id': instance.sesion_terapia_id,
    };
