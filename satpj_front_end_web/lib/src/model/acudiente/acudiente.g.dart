// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acudiente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Acudiente _$AcudienteFromJson(Map<String, dynamic> json) {
  return Acudiente(
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
    direccion: json['direccion'] as String,
    infoSesion: json['infoSesion'] as String,
    paciente: json['paciente'] == null
        ? null
        : Paciente.fromJson(json['paciente'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AcudienteToJson(Acudiente instance) => <String, dynamic>{
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
      'direccion': instance.direccion,
      'infoSesion': instance.infoSesion,
      'paciente': instance.paciente?.toJson(),
    };
