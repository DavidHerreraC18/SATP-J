<<<<<<< HEAD:satpj_front_end_web/lib/src/modelo/paciente.dart
import 'package:satpj_front_end_web/src/modelo/usuario.dart';
=======
import 'package:satpj_front_end_web/src/model/usuario.dart';
import 'dart:convert';


List<Paciente> pacienteFromJson(String str) =>
    List<Paciente>.from(json.decode(str).map((x) => Paciente.fromJson(x)));

String pacienteToJson(List<Paciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
>>>>>>> Issue-DialogoRespuestasFormulario:satpj_front_end_web/lib/src/model/paciente.dart

class Paciente extends Usuario{

   Paciente({
    this.id,
    this.name,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
    this.remitido,
  });

  int id;
  String name;
  String email;
  String address;
  String phone;
  String website;
  String company;
  bool remitido;

factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        website: json["website"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "phone": phone,
        "website": website,
        "company": company,
      };

}