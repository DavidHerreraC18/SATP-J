// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auxiliar_administrativo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuxiliarAdministrativo _$AuxiliarAdministrativoFromJson(
    Map<String, dynamic> json) {
  return AuxiliarAdministrativo(
    id: json['id'] as String,
    sesiones: (json['sesiones'] as List)
        ?.map((e) => e == null
            ? null
            : SesionUsuario.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    alertasUsuario: (json['alertasUsuario'] as List)
        ?.map((e) => e == null
            ? null
            : AlertaUsuario.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    horarios: (json['horarios'] as List)
        ?.map((e) =>
            e == null ? null : Horario.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    documento: json['documento'] as String,
    tipoDocumento: json['tipoDocumento'] as String,
    nombre: json['nombre'] as String,
    apellido: json['apellido'] as String,
    email: json['email'] as String,
    telefono: json['telefono'] as String,
    tipoUsuario: json['tipoUsuario'] as String,
    infoSesion: json['infoSesion'] as String,
  );
}

Map<String, dynamic> _$AuxiliarAdministrativoToJson(
        AuxiliarAdministrativo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sesiones': instance.sesiones?.map((e) => e?.toJson())?.toList(),
      'alertasUsuario':
          instance.alertasUsuario?.map((e) => e?.toJson())?.toList(),
      'horarios': instance.horarios?.map((e) => e?.toJson())?.toList(),
      'documento': instance.documento,
      'tipoDocumento': instance.tipoDocumento,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'email': instance.email,
      'telefono': instance.telefono,
      'tipoUsuario': instance.tipoUsuario,
      'infoSesion': instance.infoSesion,
    };
