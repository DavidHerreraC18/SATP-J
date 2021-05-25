import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'horario.g.dart';

List<Horario> horarioFromJson(String str) =>
    List<Horario>.from(json.decode(str).map((x) => Horario.fromJson(x)));

String horarioToJson(List<Horario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Horario singleHorarioFromJson(String str) {
  Horario horario = Horario.fromJson(json.decode(str));
  return horario;
}

@JsonSerializable(explicitToJson: true)
class Horario {
  int id;

  Usuario usuario;

  String opcion;

  String lunes;

  String martes;

  String miercoles;

  String jueves;

  String viernes;

  String sabado;

  Horario(
      {this.id,
      this.usuario,
      this.opcion,
      this.lunes,
      this.martes,
      this.miercoles,
      this.jueves,
      this.viernes,
      this.sabado});

  factory Horario.fromJson(Map<String, dynamic> json) =>
      _$HorarioFromJson(json);

  Map<String, dynamic> toJson() => _$HorarioToJson(this);

  Map<String, List<int>> forView() {
    Map<String, List<int>> horario = {
      'lunes': null,
      'martes': null,
      'miercoles': null,
      'jueves': null,
      'viernes': null,
      'sabado': null
    };

    if (lunes != null && lunes.isNotEmpty) {
      List<int> horas = [];
      lunes.split(';').forEach((element) {
        horas.add(int.parse(element));
        horario['lunes'] = horas;
      });
    }

    if (martes != null && martes.isNotEmpty) {
      List<int> horas = [];
      martes.split(';').forEach((element) {
        horas.add(int.parse(element));
        horario['martes'] = horas;
      });
    }

    if (miercoles != null && miercoles.isNotEmpty) {
      List<int> horas = [];
      miercoles.split(';').forEach((element) {
        horas.add(int.parse(element));
        horario['miercoles'] = horas;
      });
    }

    if (jueves != null && jueves.isNotEmpty) {
      List<int> horas = [];
      jueves.split(';').forEach((element) {
        horas.add(int.parse(element));
        horario['jueves'] = horas;
      });
    }

    if (viernes != null && viernes.isNotEmpty) {
      List<int> horas = [];
      viernes.split(';').forEach((element) {
        horas.add(int.parse(element));
        horario['viernes'] = horas;
      });
    }

    if (sabado != null && sabado.isNotEmpty) {
      List<int> horas = [];
      sabado.split(';').forEach((element) {
        horas.add(int.parse(element));
        horario['sabado'] = horas;
      });
    }
    return horario;
  }

  List<Map<String, String>>forViewOption() {
    List<Map<String, String>> horarioV = [];
  
    if (lunes != null && lunes.isNotEmpty) {
      lunes.split(';').forEach((element) {
        Map<String, String> horario = { };
        horario = {'lunes': element};
        horarioV.add(horario);
      });
    }

    if (martes != null && martes.isNotEmpty) {
      martes.split(';').forEach((element) {
        Map<String, String> horario = { };
        horario = {'martes': element};
        horarioV.add(horario);
      });
    }

    if (miercoles != null && miercoles.isNotEmpty) {
      miercoles.split(';').forEach((element) {
        Map<String, String> horario = { };
        horario = {'miercoles': element};
        horarioV.add(horario);
      });
    }

    if (jueves != null && jueves.isNotEmpty) {
      jueves.split(';').forEach((element) {
        Map<String, String> horario = { };
        horario = {'jueves': element};
        horarioV.add(horario);
      });
    }

    if (viernes != null && viernes.isNotEmpty) {
      viernes.split(';').forEach((element) {
       Map<String, String> horario = { };
        horario = {'viernes': element};
        horarioV.add(horario);
      });
    }

    if (sabado != null && sabado.isNotEmpty) {
      sabado.split(';').forEach((element) {
        Map<String, String> horario = { };
        horario = {'sabado': element};
        horarioV.add(horario);
      });
    }
    return horarioV;
  }

 forReques(Map<String, List<int>> horario) {
    
    if (horario['lunes'] != null) {
      lunes = '';
      int i = 0;
      horario['lunes'].forEach((element) {
       if(i != horario['lunes'].length - 1 && element != null)
          lunes += element.toString() + ';';
       else
          lunes += element.toString();
       i++;
      });
    }

    if (horario['martes'] != null) {
      martes = '';
      int i = 0;
      horario['martes'].forEach((element) {
       if(i != horario['martes'].length - 1 && element != null)
          martes += element.toString() + ';';
       else
          martes += element.toString();
       i++;
      });
    }

    if (horario['miercoles'] != null) {
      miercoles = '';
      int i = 0;
      horario['miercoles'].forEach((element) {
       if(i != horario['miercoles'].length - 1 && element != null)
          miercoles += element.toString() + ';';
       else
          miercoles += element.toString();
       i++;
      });
    }

    if (horario['jueves'] != null ) {
      jueves = '';
      int i = 0;
      horario['jueves'].forEach((element) {
       if(i != horario['jueves'].length - 1 && element != null)
          jueves += element.toString() + ';';
       else
          jueves += element.toString();
       i++;
      });
    }

    if (horario['viernes'] != null) {
      viernes = '';
      int i = 0;
      horario['viernes'].forEach((element) {
       if(i != horario['viernes'].length - 1 && element != null)
          viernes += element.toString() + ';';
       else
          viernes += element.toString();
       i++;
      });
    }

    if (horario['sabado'] != null) {
      sabado = '';
      int i = 0;
      horario['sabado'].forEach((element) {
       if(i != horario['sabado'].length - 1 && element != null)
          sabado += element.toString() + ';';
       else
          sabado += element.toString();
       i++;
      });
    }


  }
}
