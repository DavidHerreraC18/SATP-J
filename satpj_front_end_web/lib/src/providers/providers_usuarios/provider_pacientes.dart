import 'dart:async';

import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:http/http.dart' as http;
import '../api_definition.dart';

const String _path = "/pacientes";

class ProviderPacientes {
  static Future<String> crearPaciente(Paciente pacienteNuevo) async {
    Map<String, dynamic> paciente = pacienteNuevo.toJson();

    final _completer = Completer<String>();

    try {

      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();

      final resp = await http.post(Uri.http(ApiDefinition.url, _path),
          headers: ApiDefinition.header, body: paciente);
      
      print("RESPUESTA" + resp.body);
      
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }

    return _completer.future;
  }

  static Future<List<Paciente>> findByIdPaciente(String idPaciente) async {

    final _completer = Completer<List<Paciente>>();
    Paciente paciente = new Paciente();
    
    try {
      print('ID PACIENTE ' + idPaciente);
      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();
  
      final resp = await http.get(
          Uri.http(ApiDefinition.url, _path+'/'+idPaciente),
          headers: ApiDefinition.header);

      if (resp.statusCode == 200) {
        final _data = pacienteFromJson(resp.body);
        _completer.complete(_data);
        print("JSON RECIBIDO" + resp.body);
      }
    } catch (exc) {
       print("Error en provider" + exc);
      _completer.completeError(paciente);
    }
     return _completer.future;
    }
}
