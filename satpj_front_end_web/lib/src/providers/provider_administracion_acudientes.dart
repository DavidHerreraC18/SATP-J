import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/acudiente/acudiente.dart';
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderAdministracionAcudientes {
  static Future<List<Acudiente>> traerAcudientesPaciente(
      Paciente paciente) async {
    //
    final _completer = Completer<List<Acudiente>>();

    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
      };
      final resp = await http.get(
          Uri.http(_url, "/pacientes/" + paciente.id + "/acudientes"),
          headers: headers);

      if (resp.statusCode == 200) {
        final _data = acudienteFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (exc) {
      _completer.completeError(<Paciente>[]);
    }

    return _completer.future;
  }
}
