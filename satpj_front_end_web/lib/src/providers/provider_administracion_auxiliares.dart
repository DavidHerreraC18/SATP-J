import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/auxiliar_administrativo/auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAdministracionAuxiliares {
  static Future<List<AuxiliarAdministrativo>> traerAuxiliares() async {
    //
    final _completer = Completer<List<AuxiliarAdministrativo>>();

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
          await http.get(Uri.http(_url, "/auxiliares"), headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = auxiliarAdministrativoFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<AuxiliarAdministrativo>[]);
    }

    return _completer.future;
  }

  static Future<AuxiliarAdministrativo> buscarAuxiliar(
      String auxiliarId) async {
    //
    final _completer = Completer<AuxiliarAdministrativo>();

    try {
      //ProviderAuntenticacion.extractToken();
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      };
      final resp = await http.get(Uri.http(_url, "/auxiliares/" + auxiliarId),
          headers: headers);
      print("JSON RECIBIDO" + resp.body);
      if (resp.statusCode == 200) {
        final _data = singleAuxiliarFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      print("Error en provider" + exc);
      _completer.completeError(<AuxiliarAdministrativo>[]);
    }

    return _completer.future;
  }
}
