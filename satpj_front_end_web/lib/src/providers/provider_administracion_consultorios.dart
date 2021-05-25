import 'dart:async';

import 'package:satpj_front_end_web/src/model/consultorio/consultorio.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:http/http.dart' as http;

const _url = "localhost:8082";

class ProviderAdministracionConsultorios {
  static Future<List<Consultorio>> traerConsultorios() async {
    //
    final _completer = Completer<List<Consultorio>>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp =
          await http.get(Uri.http(_url, "/consultorios"), headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = consultorioFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<Consultorio>[]);
    }

    return _completer.future;
  }
}
