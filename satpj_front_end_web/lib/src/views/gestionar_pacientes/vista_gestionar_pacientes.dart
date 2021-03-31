import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
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
                showDialog(context: context, builder: (context) => DialogoCrearPaciente(paciente: paciente));
              },
            ),
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
