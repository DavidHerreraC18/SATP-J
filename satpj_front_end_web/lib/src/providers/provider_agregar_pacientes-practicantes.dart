import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante_paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAgregarPracticantesPacientes {
  static Future<List<PracticantePaciente>> traerPracticantesPacientes(
      String idpracticante) async {
    //
    final _completer = Completer<List<PracticantePaciente>>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      print("ID practicante seleccionado: " + idpracticante);
      final resp = await http.get(
          Uri.http(_url, "/practicantes/pacientes/" + idpracticante),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = practicantePacienteFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Paciente>[]);
    }

    return _completer.future;
  }

  static Future<String> borrarPracticantePaciente(
      String idpracticante, String idpaciente) async {
    //
    final _completer = Completer<String>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      print("IDs que se mandan: " + idpracticante + " " + idpaciente);
      final resp = await http.delete(
          Uri.http(_url, "/practicantes/" + idpracticante + "/" + idpaciente),
          headers: headers);
      if (resp.statusCode == 200) {
        _completer.complete(resp.body);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError("ERROR");
    }

    return _completer.future;
  }

  static Future<String> crearPracticantePaciente(
      String idpracticante, String idpaciente) async {
    //
    final _completer = Completer<String>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      print("IDs que se mandan: " + idpracticante + " " + idpaciente);
      final resp = await http.post(
          Uri.http(_url,
              "/practicantes/pacientes/" + idpracticante + "/" + idpaciente),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = practicantePacienteFromJson(resp.body);
        _completer.complete(resp.body);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError("Error");
    }

    return _completer.future;
  }
}
