import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/views/agendar_citas/dialogo_sesion_terapia.dart';
import 'package:satpj_front_end_web/src/views/documentacion/dialogo_consentimiento_principal.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/dialogo_crear_paciente.dart';

import 'dialogo_editar_paciente.dart';
import 'dialogo_visualizar_paciente.dart';

class VistaGestionarPacientes extends StatefulWidget {
  
  static const route = '/gestionar-pacientes';  
  
  VistaGestionarPacientes();

  @override
  _VistaGestionarPacientesState createState() =>
      _VistaGestionarPacientesState();
}

class _VistaGestionarPacientesState extends State<VistaGestionarPacientes> {
  
  Paciente paciente = new Paciente();
  
  crearPacienteTemporal(){
    paciente.nombre = 'Pepito';
    paciente.apellido = 'Gómez';
    paciente.tipoDocumento = 'Tarjeta de Identidad';
    paciente.documento = '1234567';
    paciente.edad = 15;
    paciente.email = 'pepito@gmail.com';
    paciente.telefono = '32324214';
    paciente.direccion = 'Calle 23 # 44-20';
    paciente.estrato = 3;
    paciente.supervisor = new Supervisor();
    paciente.supervisor.nombre = 'Juanito';
    paciente.supervisor.apellido = 'Rodriguez';

  }

  @override
  void initState() { 
    crearPacienteTemporal();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    print(paciente.nombre);
    return Scaffold(
       appBar: toolbarAuxiliarAdministrativo(context),
       body: Row(
        children: [
           IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              color: kPrimaryColor,
              onPressed: () {
                showDialog(context: context, builder: (context) => DialogoCrearPaciente());
              },
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: kPrimaryColor,
              ),
              color: kPrimaryColor,
              onPressed: () {
                showDialog(context: context, builder: (context) => DialogoAgendarSesionTerapia(paciente: paciente,));
              },
            ),
            DialogoCrearPaciente(),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              color: kPrimaryColor,

              onPressed: () {
                showDialog(context: context, builder: (context) => DialogoEditarPaciente(paciente: paciente));
              },
            ),
            Container(
                        alignment: Alignment.center,
                        height: 20.0,
                        constraints:
                            BoxConstraints(minWidth: 50, maxWidth: 350),
                        width: 100,
                        child: DialogoEditarPaciente(paciente: paciente),
            ),

             Container(
                        alignment: Alignment.center,
                        height: 20.0,
                        constraints:
                            BoxConstraints(minWidth: 50, maxWidth: 350),
                        width: 100,
                        child: DialogoConsentimientoPrincipal(),
                      ),
         
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              color: kPrimaryColor,

              onPressed: () {
                showDialog(context: context, builder: (context) => DialogoVisualizarPaciente(paciente: paciente));
              },
            ),
         ],
      ),
    );
  }
}
