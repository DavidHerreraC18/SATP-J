import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/paciente.dart';

const _url= "localhost:8082";

class ProviderAdministracionPacientes{


  static Future<List<Paciente>> traerPacientes() async {
    //
    final _completer = Completer<List<Paciente>>();

    try {
      final resp = await http.get(Uri.http(_url, "pacientes"));

      if (resp.statusCode == 200) {
        //
        //final _data = pacienteFromJson(resp.body);
        //_completer.complete(_data);
      }
    } catch (exc) {
      _completer.completeError(<Paciente>[]);
    }

    return _completer.future;
  }
}