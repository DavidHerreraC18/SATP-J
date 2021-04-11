// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paciente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paciente _$PacienteFromJson(Map<String, dynamic> json) {
  return Paciente(
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
    supervisor: json['supervisor'] == null
        ? null
        : Supervisor.fromJson(json['supervisor'] as Map<String, dynamic>),
    grupo: json['grupo'] == null
        ? null
        : Grupo.fromJson(json['grupo'] as Map<String, dynamic>),
    practicantesPaciente: (json['practicantesPaciente'] as List)
        ?.map((e) => e == null
            ? null
            : PracticantePaciente.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    documentoPaciente: (json['documentoPaciente'] as List)
        ?.map((e) => e == null
            ? null
            : DocumentoPaciente.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    paqueteSesion: (json['paqueteSesion'] as List)
        ?.map((e) => e == null
            ? null
            : PaqueteSesion.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    acudientes: (json['acudientes'] as List)
        ?.map((e) =>
            e == null ? null : Acudiente.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    formulario: json['formulario'] == null
        ? null
        : Formulario.fromJson(json['formulario'] as Map<String, dynamic>),
    estadoAprobado: json['estadoAprobado'] as String,
    estrato: json['estrato'] as int,
    edad: json['edad'] as int,
    remitido: json['remitido'] as bool,
  );
}

Map<String, dynamic> _$PacienteToJson(Paciente instance) => <String, dynamic>{
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
      'supervisor': instance.supervisor?.toJson(),
      'grupo': instance.grupo?.toJson(),
      'practicantesPaciente':
          instance.practicantesPaciente?.map((e) => e?.toJson())?.toList(),
      'documentoPaciente':
          instance.documentoPaciente?.map((e) => e?.toJson())?.toList(),
      'paqueteSesion':
          instance.paqueteSesion?.map((e) => e?.toJson())?.toList(),
      'acudientes': instance.acudientes?.map((e) => e?.toJson())?.toList(),
      'formulario': instance.formulario?.toJson(),
      'estadoAprobado': instance.estadoAprobado,
      'estrato': instance.estrato,
      'edad': instance.edad,
      'remitido': instance.remitido,
    };
