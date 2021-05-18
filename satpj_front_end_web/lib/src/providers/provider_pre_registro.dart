import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/acudiente/acudiente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/providers/api_definition.dart';

const _path = "/formularios";

class ProviderPreRegistro {
  static Future<String> crearFormularioGrupo(
      Formulario formularioNuevo, Grupo grupoNuevo) async {
    final _completer = Completer<String>();

    try {
      for (Paciente paciente in grupoNuevo.integrantes) {
        paciente.id = await ProviderAuntenticacion.registerWithEmailPassword(
            paciente.email, paciente.documento);
      }

      String formulario = jsonEncode(formularioNuevo.toJson());
      print("RESPUESTA PREVIA" + formulario.toString());

      String grupo = jsonEncode(grupoNuevo.toJson());
      print("RESPUESTA PREVIA" + grupo.toString());

      final resp = await http.post(
          Uri.http(ApiDefinition.url, _path + "/grupal"),
          headers: ApiDefinition.headerWithoutAuthorization,
          body: grupo);

      print("RESPUESTA" + resp.body);
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static Future<String> crearFormularioIndividual(
      Formulario formularioNuevo, Paciente paciente) async {
    final _completer = Completer<String>();

    try {
      paciente.id = await ProviderAuntenticacion.registerWithEmailPassword(
          paciente.email, paciente.documento);
      paciente.tipoUsuario = "Paciente";

      if (paciente != null) {
        if (paciente.acudientes != null) {
          if (paciente.acudientes.length > 0) {
            for (Acudiente a in paciente.acudientes) {
              a.id = await ProviderAuntenticacion.registerWithEmailPassword(
                  a.email, a.documento);
              a.tipoUsuario = "Acudiente";
            }
          }
        }
      }

      formularioNuevo.paciente = paciente;

      String formulario = jsonEncode(formularioNuevo.toJson());
      print("RESPUESTA PREVIA" + formulario.toString());

      final resp = await http.post(Uri.http(ApiDefinition.url, _path),
          headers: ApiDefinition.headerWithoutAuthorization, body: formulario);

      print("RESPUESTA" + resp.body);
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }
}
