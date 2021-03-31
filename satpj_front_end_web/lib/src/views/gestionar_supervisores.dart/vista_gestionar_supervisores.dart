import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/supervisor.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores.dart/dialogo_crear_supervisor.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores.dart/dialogo_editar_supervisor.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores.dart/dialogo_visualizar_supervisor.dart';

class VistaGestionarSupervisores extends StatefulWidget {
  
  static const route = '/gestionar-supervisores';  
  
  VistaGestionarSupervisores();

  @override
  _VistaGestionarSupervisoresState createState() =>
      _VistaGestionarSupervisoresState();
}

class _VistaGestionarSupervisoresState extends State<VistaGestionarSupervisores> {
  
  Supervisor supervisor = new Supervisor();
  
  crearPacienteTemporal(){
    supervisor.nombre = 'Pepito';
    supervisor.apellido = 'Gómez';
    supervisor.tipoDocumento = 'Tarjeta de Identidad';
    supervisor.documento = '1234567';
    supervisor.email = 'pepito@gmail.com';
    supervisor.telefono = '32324214';
    supervisor.direccion = 'Calle 23 # 44-20';
    supervisor.enfoque = 'Sistemico';
 
  }

  @override
  void initState() { 
    crearPacienteTemporal();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    print(supervisor.nombre);
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
                showDialog(context: context, builder: (context) => DialogoCrearSupervisor(supervisor: supervisor));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              color: kPrimaryColor,

              onPressed: () {
                showDialog(context: context, builder: (context) => DialogoEditarSupervisor(supervisor: supervisor));
              },
            ),

            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              color: kPrimaryColor,

              onPressed: () {
                showDialog(context: context, builder: (context) => DialogoVisualizarSupervisor(supervisor: supervisor));
              },
            ),
         ],
      ),
    );
  }
}
