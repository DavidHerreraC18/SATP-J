import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/acudiente/acudiente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/providers/api_definition.dart';

const _path = "/formularios";

class ProviderPreRegistro {
  static Future<String> crearFormularioGrupo(
      Formulario formularioNuevo, Grupo grupoNuevo) async {
    final _completer = Completer<String>();
    
    try {
      for (Paciente paciente in grupoNuevo.integrantes) {
        (paciente as Usuario).id =
            await ProviderAuntenticacion.registerWithEmailPassword(
                paciente.email, paciente.documento);
      }

      String formulario = jsonEncode(formularioNuevo.toJson());
      print("RESPUESTA PREVIA" + formulario.toString());

      String grupo = jsonEncode(grupoNuevo.toJson());
      print("RESPUESTA PREVIA" + grupo.toString());

      final resp = await http.post(Uri.http(ApiDefinition.url, _path+"/grupal"),
          headers: ApiDefinition.headerWithoutAuthorization, body: grupo);

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
      (paciente as Usuario).id =
          await ProviderAuntenticacion.registerWithEmailPassword(
              paciente.email, paciente.documento);
      paciente.tipoUsuario = "Paciente";

      if (paciente != null) {
        if (paciente.acudientes != null) {
          if (paciente.acudientes.length > 0) {
            for (Acudiente a in paciente.acudientes) {
              (a as Usuario).id =
                  await ProviderAuntenticacion.registerWithEmailPassword(
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

  static Future<List<Formulario>> obtenerFormularioIndividual(String idFormulario) async {
    final _completer = Completer<List<Formulario>>();

    try {

      final resp = await http.get(Uri.http(ApiDefinition.url, _path + '/' + idFormulario),
          headers: ApiDefinition.headerWithoutAuthorization);
      
      
      print("RESPUESTA" + resp.body);

      if (resp.statusCode == 200) {
        final _data = formularioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (e) {
      print(e);
      _completer.completeError(<Formulario>[]);
    }
    return _completer.future;
  }

  static Future<String> editarFormularioIndividual(
      Formulario formularioU, Paciente paciente) async {
    final _completer = Completer<String>();

    try {

      formularioU.paciente = paciente;

      String formulario = jsonEncode(formularioU.toJson());
      print("RESPUESTA PREVIA" + formulario.toString());

      final resp = await http.put(Uri.http(ApiDefinition.url, _path+'/'+formularioU.id.toString()),
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
