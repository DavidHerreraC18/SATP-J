import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia_actual.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAdministracionUsuarios {
  static Future<Usuario> buscarUsuario(String usuarioId) async {
    //
    final _completer = Completer<Usuario>();

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
      final resp = await http.get(Uri.http(_url, "/usuarios/" + usuarioId),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleUsuarioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Usuario>[]);
    }

    return _completer.future;
  }

  static Future<SesionTerapiaActual> obtenerSesionTerapiaActual(
      String usuarioId) async {
    final _completer = Completer<SesionTerapiaActual>();

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
          Uri.http(_url, "/sesiones-posibles/" + usuarioId),
          headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleSesionTerapiaActualFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<SesionTerapiaActual>[]);
    }

    return _completer.future;
  }

  static Future<String> editarUsuario(Usuario usuario) async {
    //
    final _completer = Completer<String>();

    String id = usuario.id;

    String jsonUsuario = jsonEncode(usuario.toJson());

    print("JSON GENERADO" + jsonUsuario);
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
      final resp = await http.put(Uri.http(_url, "/usuarios/" + id),
          headers: headers, body: jsonUsuario);
      _completer.complete(resp.body);
    } catch (e) {
      print("Error en provider" + e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<Horario> traerHorarioSeleccionado(String idUsuario) async {
    //
    final _completer = Completer<Horario>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
      };
      final resp = await http.get(
          Uri.http(_url, "/usuarios/horarios/seleccionado/" + idUsuario),
          headers: headers);
      //print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleHorarioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Horario>[]);
    }

    return _completer.future;
  }
}
