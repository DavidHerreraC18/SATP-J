import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
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
      _completer.completeError(<DocumentoPaciente>[]);
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
