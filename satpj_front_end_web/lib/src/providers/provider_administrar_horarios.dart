
import 'dart:async';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/providers/api_definition.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:http/http.dart' as http;

const _path = "/horarios";

class ProviderAdministracionHorarios {

 static Future<List<Horario>> obtenerHorariosPracticante(
      String practicanteId) async {
    final _completer = Completer<List<Horario>>();
    
    try {
      print('HOLA OBTENER PAQUETES' + practicanteId);
      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();

      final resp = await http.get(Uri.http(ApiDefinition.url, _path, {"practicanteId" : practicanteId}),
          headers: ApiDefinition.header);

      print("RESPUESTA" + resp.body);

       if (resp.statusCode == 200) {
        final _data = horarioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (e) {
      print(e);
      _completer.completeError(<Horario>[]);
    }
    return _completer.future;
  }

 static Future<String> crearHorarioPracticante(Horario horarioNuevo) async {
    final _completer = Completer<String>();
    
    try {
      
      String horario = jsonEncode(horarioNuevo.toJson());
      print("RESPUESTA PREVIA" + horario);

      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();

      final resp = await http.post(Uri.http(ApiDefinition.url, _path),
          headers: ApiDefinition.header, body: horario);

      print("RESPUESTA" + resp.body);
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

}