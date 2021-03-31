import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url= "localhost:8082";

class ProviderAdministracionFormularios{


  static Future<List<Formulario>> traerFormularios() async {
    //
    final _completer = Completer<List<Formulario>>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
      "Authorization": "Bearer " + await ProviderAuntenticacion.extractToken(),
      "Cache-Control": "no-cache",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
      };
      final resp = await http.get(Uri.http(_url, "/formularios/pendientes-aprobacion"),headers: headers);
      print(resp.body);
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        final _data = formularioFromJson(resp.body);
        print("ENTRO BUENO");
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Formulario>[]);
    }

    return _completer.future;
  }

 /*  static Future<List<Formulario>> traerFormularios() async {
    Map<String, String> headers = {
      "Authorization": "Bearer " + await ProviderAuntenticacion.extractToken(),
      "Cache-Control": "no-cache",
      /*"Accept": "*/*",*/
      /*"Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
      };
    final response = await http.get(Uri.http(_url, "/usuarios/O6mFo3YgfnUUlBUQ2RqgpKqZpc03"),headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      print(response.body);
      print(userMap);
      var user = Usuario.fromJson(userMap);
      print(user.id);
    }else{
      print("ERROOOOOR");
    }
  }*/
}