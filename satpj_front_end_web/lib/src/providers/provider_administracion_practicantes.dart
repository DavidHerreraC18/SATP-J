import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante_horas.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAdministracionPracticantes {
  static Future<List<Practicante>> traerPracticantes() async {
    //
    final _completer = Completer<List<Practicante>>();

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
          await http.get(Uri.http(_url, "/practicantes"), headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = practicanteFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Practicante>[]);
    }

    return _completer.future;
  }

  static Future<List<PracticanteHoras>> traerPracticantesHoras() async {
    //
    final _completer = Completer<List<PracticanteHoras>>();
    String aaa = await ProviderAuntenticacion.extractToken();
    print(aaa);
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
      final resp = await http.get(Uri.http(_url, "/practicantes/horas"),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = practicanteHorasFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<PracticanteHoras>[]);
    }

    return _completer.future;
  }

  static Future<Practicante> buscarPracticante(String practicanteId) async {
    //
    final _completer = Completer<Practicante>();

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
      final resp = await http.get(Uri.http(_url, "/practicantes/" + practicanteId),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = Practicante.fromJson(json.decode(resp.body));
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
    }

    return _completer.future;
  }

  static Future<String> crearPracticante(Practicante practicante) async {
    //
    final _completer = Completer<String>();

    String jsonPracticante = jsonEncode(practicante.toJson());

    print("JSON GENERADO" + jsonPracticante);
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
      final resp = await http.post(Uri.http(_url, "/practicantes"),
          headers: headers, body: jsonPracticante);
      _completer.complete(resp.body);
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<String> editarPracticante(Practicante practicante) async {
    //
    final _completer = Completer<String>();

    String id = practicante.id;

    String jsonPracticante = jsonEncode(practicante.toJson());

    print("JSON GENERADO" + jsonPracticante);
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
      final resp = await http.put(Uri.http(_url, "/practicantes/" + id),
          headers: headers, body: jsonPracticante);
      _completer.complete(resp.body);
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<String> borrarPracticante(Practicante practicante) async {
    //
    final _completer = Completer<String>();

    String id = practicante.id;

    print("ID PRACTICANTE BORRADO" + id);
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
      final resp = await http.delete(Uri.http(_url, "/practicantes/" + id),
          headers: headers);
      _completer.complete(resp.body);
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<List<Paciente>> traerPacientesActivosPracticante(
      String id) async {
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
      final resp = await http.get(
          Uri.http(_url, "/practicantes/pacientes/activos/" + id),
          headers: headers);
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
}
