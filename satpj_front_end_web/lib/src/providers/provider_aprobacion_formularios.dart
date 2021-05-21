import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAprobacionFormularios {
  static Future<List<Formulario>> traerFormularios() async {
    //
    final _completer = Completer<List<Formulario>>();

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
      final resp = await http.get(
          Uri.http(_url, "/formularios/pendientes-aprobacion"),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = formularioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Formulario>[]);
    }

    return _completer.future;
  }

  static Future<Formulario> traerFormularioPacienteId(String pacienteId) async {
    //
    final _completer = Completer<Formulario>();

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
      final resp = await http.get(
          Uri.http(_url, "/pacientes/" + pacienteId + "/formulario"),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleFormularioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Formulario>[]);
    }

    return _completer.future;
  }

  static Future<String> preAprobarPaciente(Formulario formulario) async {
    final _completer = Completer<String>();
    Paciente paciente = formulario.paciente;
    paciente.estadoAprobado = "PreAprobado";
    String json = jsonEncode(paciente.toJson());

    print("JSON GENERADO" + json);
    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.put(Uri.http(_url, "/pacientes/" + paciente.id),
          headers: headers, body: json);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static Future<String> rechazarPaciente(Formulario formulario) async {
    final _completer = Completer<String>();
    Paciente paciente = formulario.paciente;
    paciente.estadoAprobado = "NoAprobado";
    String json = jsonEncode(paciente.toJson());

    print("JSON GENERADO" + json);
    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.put(Uri.http(_url, "/pacientes/" + paciente.id),
          headers: headers, body: json);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }
}
