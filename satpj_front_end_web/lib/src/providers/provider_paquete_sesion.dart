

import 'package:satpj_front_end_web/src/model/paquete_sesion.dart';

class ProviderPaqueteSesion{

  static getPaqueteSesionPorIdPaciente(){
     return [PaqueteSesion(fecha: DateTime.now(),cantidadSesiones: 2, total: 20.0).toString(), PaqueteSesion(fecha: DateTime.now(),cantidadSesiones: 3, total: 60.0).toString()];
  }
}