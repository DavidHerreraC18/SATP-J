import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAdministracionFormularios {
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
        "Connection": "keep-alive"
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

  static Future<String> preAprobarPaciente(Formulario formulario) async {
    final _completer = Completer<String>();
    /*formulario.paciente.estadoAprobado = "PreAprobado";
    List<Formulario> formularios = [formulario];
    String json = formularioToJson(formularios);*/
    Paciente paciente = formulario.paciente;
    paciente.estadoAprobado = "PreAprobado";
    List<Paciente> pacientes = [paciente];
    String json = pacienteToJson(pacientes);

    print("JSON GENERADO" + json);
    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive"
      };
      /*final resp = await http.put(
          Uri.http(_url, "/formularios/" + formulario.id.toString()),
          headers: headers,
          body: json);*/
      final resp = await http.put(Uri.http(_url, "/pacientes/" + paciente.id),
          headers: headers, body: json);
      print("RESPUESTA" + resp.body);
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }
}
