import 'dart:convert';

import 'package:satpj_front_end_web/src/model/alerta.dart';
import 'package:satpj_front_end_web/src/model/alerta_usuario.dart';
import 'package:satpj_front_end_web/src/model/horario.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/sesion_usuario.dart';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
    
    int id;
    List<SesionUsuario> sesiones;
    List<AlertaUsuario> alertasUsuario;
    List<Horario> horarios;
    String documento;
    String tipoDocumento;
    String nombre;
    String apellido;
    String email;
    String telefono;
    String direccion;
    String tipoUsuario;
    String infoSesion;

    Usuario({
      this.id,
      this.sesiones,
      this.alertasUsuario,
      this.horarios,
      this.documento,
      this.tipoDocumento,
      this.nombre,
      this.apellido,
      this.email,
      this.telefono,
      this.tipoUsuario,
      this.infoSesion,
      this.direccion
    });
    
  factory Usuario.fromJson(Map<String, dynamic> json) {
    var list1 = json['sesiones'] as List;
    List<SesionUsuario> lsesiones = list1.map((i) => SesionUsuario.fromJson(i)).toList();
    var list2 = json['alertasUsuario'] as List;
    List<AlertaUsuario> lalertasUsuario = list2.map((i) => AlertaUsuario.fromJson(i)).toList();
    var list3 = json['horarios'] as List;
    List<Horario> lhorarios = list3.map((i) => Horario.fromJson(i)).toList();

    return Usuario(
      id: json["id"],
      sesiones: lsesiones,
      alertasUsuario: lalertasUsuario,
      horarios: lhorarios,
      documento: json["documento"],
      tipoDocumento: json["tipoDocumento"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      email: json["email"],
      telefono: json["telefono"],
      tipoUsuario: json["tipoUsuario"],
      infoSesion: json["infoSesion"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sesiones": jsonEncode(sesiones),
        "alertasUsuario": jsonEncode(alertasUsuario),
        "horarios": jsonEncode(horarios),
        "documento": documento,
        "tipoDocumento": tipoDocumento,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "telefono": telefono,
        "tipoUsuario": tipoUsuario,
        "infoSesion": infoSesion,
      };
}