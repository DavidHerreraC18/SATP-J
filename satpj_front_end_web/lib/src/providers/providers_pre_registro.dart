import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/providers/api_definition.dart';
import 'package:satpj_front_end_web/src/providers/providers_usuarios/provider_grupos.dart';
import 'package:satpj_front_end_web/src/providers/providers_usuarios/provider_pacientes.dart';
  
const _path = "grupos";

class ProviderPreRegistro {  
  
  static Future<String> crearFormularioGrupo(
      Formulario formularioNuevo, Grupo grupo) async {
    
    final _completer = Completer<String>();

    try {
      
      for(Paciente p in grupo.integrantes)
          ProviderPacientes.crearPaciente(p);
      
      ProviderGrupos.crearGrupo(grupo);

      ApiDefinition.header["Authorization"] =  "Bearer " + await ProviderAuntenticacion.extractToken();

      Map<String, dynamic> formulario = formularioNuevo.toJson();

      final resp = await http.post(Uri.http(ApiDefinition.url, _path),
          headers: ApiDefinition.header, body: formulario);

      print("RESPUESTA" + resp.body);
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }
}
