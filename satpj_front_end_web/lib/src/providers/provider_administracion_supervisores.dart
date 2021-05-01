import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAdministracionSupervisores {
  static Future<List<Supervisor>> traerSupervisores() async {
    //
    final _completer = Completer<List<Supervisor>>();

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
          await http.get(Uri.http(_url, "/supervisores"), headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = supervisorFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Supervisor>[]);
    }

    return _completer.future;
  }

  static Future<Supervisor> buscarSupervisore(String supervisorId) async {
    //
    final _completer = Completer<Supervisor>();

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
      final resp = await http.get(
          Uri.http(_url, "/supervisores/" + supervisorId),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = Supervisor.fromJson(json.decode(resp.body));
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
    }

    return _completer.future;
  }

  static Future<String> crearSupervisor(Supervisor supervisor) async {
    //
    final _completer = Completer<String>();

    String jsonSupervisor = jsonEncode(supervisor.toJson());

    print("JSON GENERADO" + jsonSupervisor);
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
      final resp = await http.post(Uri.http(_url, "/supervisores"),
          headers: headers, body: jsonSupervisor);
      _completer.complete(resp.body);
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<String> editarSupervisor(Supervisor supervisor) async {
    //
    final _completer = Completer<String>();

    String jsonSupervisor = jsonEncode(supervisor.toJson());

    String id = supervisor.id;

    print("JSON GENERADO" + jsonSupervisor);
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
      final resp = await http.put(Uri.http(_url, "/supervisores/" + id),
          headers: headers, body: jsonSupervisor);
      _completer.complete(resp.body);
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<String> borrarSupervisor(Supervisor supervisor) async {
    //
    final _completer = Completer<String>();

    String id = supervisor.id;

    print("ID SUPERVISOR BORRADO " + id);
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
      final resp = await http.delete(Uri.http(_url, "/supervisores/" + id),
          headers: headers);
      _completer.complete(resp.body);
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }
}
