
import 'dart:async';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/api_definition.dart';
import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _path = "/usuarios";

class ProviderUsuarios {
  
   static Future<List<Usuario>> obtenerUsuarioPorDocumento(
      String documento) async {
    final _completer = Completer<List<Usuario>>();
    
    try {

      final resp = await http.get(Uri.http(ApiDefinition.url, _path, {"documento" :documento}),
          headers: ApiDefinition.headerWithoutAuthorization,);

      print("RESPUESTA" + resp.body);

       if (resp.statusCode == 200) {
        final _data = usuarioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (e) {
      print(e);
      _completer.completeError(<Usuario>[]);
    }
    return _completer.future;
  }

  static Future<List<Usuario>> obtenerUsuarioPorEmail(
      String email) async {
    final _completer = Completer<List<Usuario>>();
    
    try {

      final resp = await http.get(Uri.http(ApiDefinition.url, _path, {"email" : email}),
          headers: ApiDefinition.headerWithoutAuthorization,);

      print("RESPUESTA" + resp.body);

       if (resp.statusCode == 200) {
        final _data = usuarioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (e) {
      print(e);
      _completer.completeError(<Usuario>[]);
    }
    return _completer.future;
  }
  
}