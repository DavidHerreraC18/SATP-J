import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/consultorio/consultorio.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderSesionesTerapia {
  static crearSesionTemporal() {
    SesionTerapia sesion = new SesionTerapia();
    sesion.fecha = new DateTime.now();
    sesion.consultorio = new Consultorio(consultorio: "301");
    sesion.virtual = true;
    return sesion;
  }

  static List<SesionTerapia> getSesionesTerapia() {
    return <SesionTerapia>[crearSesionTemporal(), crearSesionTemporal()];
  }

  static Future<SesionTerapia> crearSesionTerapia(
      SesionTerapia sesionTerapia) async {
    final _completer = Completer<SesionTerapia>();
    String jsonSesionTerapia = jsonEncode(sesionTerapia.toJson());

    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.post(Uri.http(_url, "/sesionterapias"),
          headers: headers, body: jsonSesionTerapia);
      if (resp.statusCode == 201) {
        final _data = singleSesionTerapiaFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static eliminarSesionTerapia(int sesionTerapiaId) async {
    final _completer = Completer<String>();
    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.delete(
          Uri.http(_url, "/sesionterapias/" + sesionTerapiaId.toString()),
          headers: headers);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static crearSesionUsuario(SesionUsuario sesionUsuario) async {
    final _completer = Completer<String>();
    String jsonSesionUsuario = jsonEncode(sesionUsuario.toJson());

    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.post(Uri.http(_url, "/sesionterapias/usuarios"),
          headers: headers, body: jsonSesionUsuario);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static Future<List<SesionUsuario>> obtenerSesionesUsuario(
      String usuarioId) async {
    final _completer = Completer<List<SesionUsuario>>();

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
          Uri.http(_url, "/sesionterapias/usuario/" + usuarioId),
          headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = sesionUsuarioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<SesionUsuario>[]);
    }

    return _completer.future;
  }

  static Future<List<SesionUsuario>> obtenerTodasSesionesUsuario(
      String usuarioId) async {
    final _completer = Completer<List<SesionUsuario>>();

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
      final resp =
          await http.get(Uri.http(_url, "/sesionterapias"), headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = sesionUsuarioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<SesionUsuario>[]);
    }

    return _completer.future;
  }
}
