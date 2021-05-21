import 'dart:async';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/comprobante_pago/comprobante_pago.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion/paquete_sesion.dart';

import 'package:satpj_front_end_web/src/providers/api_definition.dart';
import 'package:http/http.dart' as http;
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

const _pathPaquetes = "/paquetesesiones";
const _pathComprobantes = "/comprobantespago";

class ProviderGestionPagos{

  static Future<List<PaqueteSesion>> obtenerPaquetesSesionesPaciente(
      String pacienteId) async {
    final _completer = Completer<List<PaqueteSesion>>();
    
    try {
      print('HOLA OBTENER PAQUETES' + pacienteId);
      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();

      final resp = await http.get(Uri.http(ApiDefinition.url, _pathPaquetes, {"pacienteId" : pacienteId}),
          headers: ApiDefinition.header);

      print("RESPUESTA" + resp.body);

       if (resp.statusCode == 200) {
        final _data = paqueteSesionFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (e) {
      print(e);
      _completer.completeError(<PaqueteSesion>[]);
    }
    return _completer.future;
  }

  static Future<String> crearPaqueteSesion(
      PaqueteSesion paqueteNuevo) async {
    final _completer = Completer<String>();
    
    try {
      
      String paqueteSesion = jsonEncode(paqueteNuevo.toJson());
      print("RESPUESTA PREVIA" + paqueteSesion.toString());

      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();
      print(ApiDefinition.url+_pathPaquetes);
      final resp = await http.post(Uri.http(ApiDefinition.url, _pathPaquetes),
          headers: ApiDefinition.header, body: paqueteSesion);

      print("RESPUESTA" + resp.body);
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

  static Future<List<ComprobantePago>> obtenerComprobantesPagosPacientes() async {
    final _completer = Completer<List<ComprobantePago>>();
    
    try {
      
      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();

      final resp = await http.get(Uri.http(ApiDefinition.url, _pathComprobantes),
          headers: ApiDefinition.header);

      print("RESPUESTA" + resp.body);

       if (resp.statusCode == 200) {
        final _data = comprobantePagoFromJson(resp.body);
        _completer.complete(_data);
      }
    } catch (e) {
      print(e);
      _completer.completeError(<ComprobantePago>[]);
    }
    return _completer.future;
  }

   static Future<String> crearComprobantePagoPaciente(
      ComprobantePago comprobanteNuevo) async {
    final _completer = Completer<String>();

    try {
      String comprobante = jsonEncode(comprobanteNuevo.toJson());
      print("RESPUESTA PREVIA" + comprobante.toString());

      ApiDefinition.header["Authorization"] =
          "Bearer " + await ProviderAuntenticacion.extractToken();

      final resp = await http.post(Uri.http(ApiDefinition.url, _pathComprobantes),
          headers: ApiDefinition.header, body: comprobante);

      print("RESPUESTA" + resp.body);
      _completer.complete("Exito");
    } catch (e) {
      print(e);
      _completer.completeError("Error");
    }
    return _completer.future;
  }

}