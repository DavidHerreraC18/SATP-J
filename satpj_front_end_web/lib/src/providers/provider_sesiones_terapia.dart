
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';

class ProviderSesionesTerapia {
  
  static crearSesionTemporal() {
    SesionTerapia sesion = new SesionTerapia(); 
    sesion.fecha = new DateTime.now();
    sesion.hora = new DateTime.now();
    sesion.consultorio = 'Tarjeta de Identidad';
    sesion.virtual = true;
    return sesion;
  }

   static List<SesionTerapia> getSesionesTerapia(){
      return <SesionTerapia>[crearSesionTemporal(), crearSesionTemporal()];
   }

}