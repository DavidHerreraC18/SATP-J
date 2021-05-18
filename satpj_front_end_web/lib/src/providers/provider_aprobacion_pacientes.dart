import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAprobacionPacientes {
  static Future<List<FormularioExtra>>
      traerFormulariosExtrasPreAprobados() async {
    //
    final _completer = Completer<List<FormularioExtra>>();

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
          Uri.http(_url, "/formularios-extra/pre-aprobados"),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = formularioExtraFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<FormularioExtra>[]);
    }

    return _completer.future;
  }

  static Future<String> crearFormularioExtra(
      FormularioExtra formularioExtra) async {
    final _completer = Completer<String>();
    //print(fotoPerfil);

    String jsonFormularioExtra = jsonEncode(formularioExtra.toJson());

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
      final resp = await http.post(Uri.http(_url, "/formularios-extra"),
          headers: headers, body: jsonFormularioExtra);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static Future<String> aprobarPaciente(Paciente paciente) async {
    final _completer = Completer<String>();
    paciente.estadoAprobado = "Aprobado";
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

  static Future<String> aprobarPacienteGrupo(Paciente paciente) async {
    final _completer = Completer<String>();
    paciente.estadoAprobado = "GrupoNoAprobado";
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

  static Future<String> rechazarPaciente(Paciente paciente) async {
    final _completer = Completer<String>();
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
