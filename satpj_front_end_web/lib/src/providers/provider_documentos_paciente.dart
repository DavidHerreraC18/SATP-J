import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _url = "localhost:8082";

class ProviderDocumentosPaciente {
  static Future<String> documentarPacienteFoto(
      Paciente pacienteActual, Uint8List _fotoDocumento) async {
    final _completer = Completer<String>();
    String nombrePaciente =
        pacienteActual.nombre + " " + pacienteActual.apellido;
    String fotoPerfil = Base64Codec().encode(_fotoDocumento);
    //print(fotoPerfil);
    DocumentoPaciente documentoFoto = new DocumentoPaciente(
      nombre: "FotoPerfil-" + nombrePaciente,
      radicacion: DateTime.now(),
      tipo: "FotoPerfil",
      contenido: fotoPerfil,
      paciente: pacienteActual,
      vencimiento: DateTime.now(),
    );
    String jsonFoto = jsonEncode(documentoFoto.toJson());

    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.post(Uri.http(_url, "/documentos"),
          headers: headers, body: jsonFoto);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static Future<String> documentarPacienteConsentimientoP(
      Paciente pacienteActual, Uint8List _consentimientoPrincipal) async {
    final _completer = Completer<String>();
    String nombrePaciente =
        pacienteActual.nombre + " " + pacienteActual.apellido;
    String consentimientoPrincipal =
        Base64Codec().encode(_consentimientoPrincipal);
    //print(consentimientoPrincipal);
    DocumentoPaciente documentoConsentimientoPrincipal = new DocumentoPaciente(
        nombre: "ConsentimientoPrincipal-" + nombrePaciente,
        radicacion: DateTime.now(),
        tipo: "ConsentimientoPrincipal",
        contenido: consentimientoPrincipal,
        paciente: pacienteActual,
        vencimiento: DateTime.now());
    String jsonConsentimientoPrincipal =
        jsonEncode(documentoConsentimientoPrincipal.toJson());

    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.post(Uri.http(_url, "/documentos"),
          headers: headers, body: jsonConsentimientoPrincipal);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static Future<String> documentarPacienteReciboPago(
      Paciente pacienteActual, Uint8List _reciboPago) async {
    final _completer = Completer<String>();
    String nombrePaciente =
        pacienteActual.nombre + " " + pacienteActual.apellido;
    String reciboPago = Base64Codec().encode(_reciboPago);
    //print(reciboPago);
    DocumentoPaciente documentoReciboPago = new DocumentoPaciente(
        nombre: "ReciboPago-" + nombrePaciente,
        radicacion: DateTime.now(),
        tipo: "ReciboPago",
        contenido: reciboPago,
        paciente: pacienteActual,
        vencimiento: DateTime.now());
    String jsonReciboPago = jsonEncode(documentoReciboPago.toJson());

    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.post(Uri.http(_url, "/documentos"),
          headers: headers, body: jsonReciboPago);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static Future<String> documentarPacienteConsentimientoTP(
      Paciente pacienteActual, Uint8List _consentimientoTP) async {
    final _completer = Completer<String>();
    String nombrePaciente =
        pacienteActual.nombre + " " + pacienteActual.apellido;
    String consentimientoTP = Base64Codec().encode(_consentimientoTP);
    //print(consentimientoTP);
    DocumentoPaciente documentoConsentimientoTP = new DocumentoPaciente(
      nombre: "ConsentimientoTP-" + nombrePaciente,
      radicacion: DateTime.now(),
      tipo: "ConsentimientoTP",
      contenido: consentimientoTP,
      paciente: pacienteActual,
      vencimiento: DateTime.now(),
    );
    String jsonConsentimientoTP =
        jsonEncode(documentoConsentimientoTP.toJson());

    try {
      Map<String, String> headers = {
        "Authorization":
            "Bearer " + await ProviderAuntenticacion.extractToken(),
        "Cache-Control": "no-cache",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final resp = await http.post(Uri.http(_url, "/documentos"),
          headers: headers, body: jsonConsentimientoTP);
      _completer.complete(resp.body);
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }
}
