// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) {
  return Usuario(
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
  );
}

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
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
    };
