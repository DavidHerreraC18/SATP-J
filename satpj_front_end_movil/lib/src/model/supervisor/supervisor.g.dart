// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supervisor _$SupervisorFromJson(Map<String, dynamic> json) {
  return Supervisor(
    id: json['id'] as String,
    documento: json['documento'] as String,
    tipoDocumento: json['tipoDocumento'] as String,
    nombre: json['nombre'] as String,
    apellido: json['apellido'] as String,
    email: json['email'] as String,
    telefono: json['telefono'] as String,
    tipoUsuario: json['tipoUsuario'] as String,
    direccion: json['direccion'] as String,
    infoSesion: json['infoSesion'] as String,
    enfoque: json['enfoque'] as String,
    pacientes: (json['pacientes'] as List)
        ?.map((e) =>
            e == null ? null : Paciente.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SupervisorToJson(Supervisor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documento': instance.documento,
      'tipoDocumento': instance.tipoDocumento,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'email': instance.email,
      'telefono': instance.telefono,
      'tipoUsuario': instance.tipoUsuario,
      'direccion': instance.direccion,
      'infoSesion': instance.infoSesion,
      'enfoque': instance.enfoque,
      'pacientes': instance.pacientes?.map((e) => e?.toJson())?.toList(),
    };
