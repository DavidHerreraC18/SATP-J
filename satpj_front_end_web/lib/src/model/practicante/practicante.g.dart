// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practicante.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Practicante _$PracticanteFromJson(Map<String, dynamic> json) {
  return Practicante(
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
    practicante: (json['practicante'] as List)
        ?.map((e) => e == null
            ? null
            : PracticantePaciente.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pregrado: json['pregrado'] as bool,
    semestre: json['semestre'] as int,
    enfoque: json['enfoque'] as String,
    activo: json['activo'] as bool,
  );
}

Map<String, dynamic> _$PracticanteToJson(Practicante instance) =>
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
      'direccion': instance.direccion,
      'infoSesion': instance.infoSesion,
      'practicante': instance.practicante?.map((e) => e?.toJson())?.toList(),
      'pregrado': instance.pregrado,
      'semestre': instance.semestre,
      'enfoque': instance.enfoque,
      'activo': instance.activo,
    };
