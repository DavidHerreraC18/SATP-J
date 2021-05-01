import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAdministracionPacientes {
  static Future<List<Paciente>> traerPacientes() async {
    //
    final _completer = Completer<List<Paciente>>();

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
      final resp =
          await http.get(Uri.http(_url, "/pacientes"), headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = pacienteFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Paciente>[]);
    }

    return _completer.future;
  }

  static Future<Paciente> buscarPaciente(String pacienteId) async {
    //
    final _completer = Completer<Paciente>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      };
      final resp = await http.get(Uri.http(_url, "/pacientes/" + pacienteId),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singlePacienteFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<DocumentoPaciente>[]);
    }

    return _completer.future;
  }

  static Future<List<DocumentoPaciente>> traerDocumentosPaciente(
      Paciente pacienteActual) async {
    //
    final _completer = Completer<List<DocumentoPaciente>>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive"
      };
      final resp = await http.get(
          Uri.http(_url, "/pacientes/" + pacienteActual.id + "/documentos"),
          headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = documentoPacienteFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<DocumentoPaciente>[]);
    }

    return _completer.future;
  }

  static Future<FormularioExtra> traerFormularioExtraPaciente(
      Paciente pacienteActual) async {
    //
    final _completer = Completer<FormularioExtra>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
      };
      final resp = await http.get(
          Uri.http(
              _url, "/pacientes/" + pacienteActual.id + "/formulario-extra"),
          headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleFormularioExtraFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<FormularioExtra>[]);
    }

    return _completer.future;
  }
}
