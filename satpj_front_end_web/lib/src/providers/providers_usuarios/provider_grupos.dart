
import 'dart:async';

import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';
import 'package:satpj_front_end_web/src/providers/api_definition.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:http/http.dart' as http;

const _path = "/grupos";

class ProviderGrupos {
  
  static Future<String> crearGrupo(Grupo grupoNuevo) async {
    Map<String, dynamic> grupo = grupoNuevo.toJson();

    final _completer = Completer<String>();

    try {

      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();

      final resp = await http.post(Uri.http(ApiDefinition.url, _path),
          headers: ApiDefinition.header, body: grupo);
      
      print("RESPUESTA" + resp.body);
      
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }
}