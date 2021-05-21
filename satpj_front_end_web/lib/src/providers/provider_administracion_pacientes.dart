import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
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
      _completer.completeError(<Paciente>[]);
    }

    return _completer.future;
  }

  static Future<String> crearPaciente(Paciente paciente) async {
    //
    final _completer = Completer<String>();
    print("PACIENTE A CREAR " + paciente.id);
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
      final resp =
          await http.delete(Uri.http(_url, "/pacientes/"), headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        //final _data = singlePacienteFromJson(resp.body);
        _completer.complete(resp.body);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<String> editarPaciente(Paciente paciente) async {
    //
    final _completer = Completer<String>();

    String id = paciente.id;

    String jsonPaciente = jsonEncode(paciente.toJson());

    print("JSON GENERADO" + jsonPaciente);
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
      final resp = await http.put(Uri.http(_url, "/pacientes/" + id),
          headers: headers, body: jsonPaciente);
      _completer.complete(resp.body);
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<String> borrarPaciente(Paciente paciente) async {
    //
    final _completer = Completer<String>();
    print("PACIENTE A BORRAR " + paciente.id);
    String pacienteID = paciente.id;
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
      final resp = await http.delete(Uri.http(_url, "/pacientes/" + pacienteID),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        _completer.complete(resp.body);
      }
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
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
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8'
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
        'Content-Type': 'application/json; charset=UTF-8'
      };
      final resp = await http.get(
          Uri.http(
              _url, "/pacientes/" + pacienteActual.id + "/formulario-extra"),
          headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleFormularioExtraFromJson(resp.body);
        _completer.complete(_data);
      } else {
        final _data = null;
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<FormularioExtra>[]);
    }

    return _completer.future;
  }

  static Future<Supervisor> traerSupervisorPaciente(
      Paciente pacienteActual) async {
    //
    final _completer = Completer<Supervisor>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        'Content-Type': 'application/json; charset=UTF-8'
      };
      final resp = await http.get(
          Uri.http(_url, "/pacientes/" + pacienteActual.id + "/supervisor"),
          headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleSupervisorFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Supervisor>[]);
    }

    return _completer.future;
  }

  static Future<Practicante> traerPracticanteActivoPaciente(
      String idPaciente) async {
    //

    final _completer = Completer<Practicante>();

    try {
      //ProviderAuntenticacion.extractToken();

      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
      };

      final resp = await http.get(
          Uri.http(_url, "/pacientes/practicante/" + idPaciente),
          headers: headers);

      //print("JSON RECIBIDO" + resp.body);

      if (resp.statusCode == 200) {
        final _data = singlePracticanteFromJson(resp.body);

        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);

      _completer.completeError(<Practicante>[]);
    }

    return _completer.future;
  }

  static Future<Grupo> traerGrupoPaciente(String pacienteActual) async {
    //
    final _completer = Completer<Grupo>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        'Content-Type': 'application/json; charset=UTF-8'
      };
      final resp = await http.get(
          Uri.http(_url, "/" + pacienteActual + "/grupo"),
          headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleGrupoFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Grupo>[]);
    }

    return _completer.future;
  }
}
