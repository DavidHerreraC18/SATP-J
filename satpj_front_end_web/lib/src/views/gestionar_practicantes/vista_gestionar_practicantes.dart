import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/dialogo_crear_practicante.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/dialogo_editar_practicante.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/dialogo_visualizar_practicante.dart';

class VistaGestionarPracticantes extends StatefulWidget {
  
  static const route = '/gestionar-practicantes';  
  
  VistaGestionarPracticantes();

  @override
  _VistaGestionarPracticantesState createState() =>
      _VistaGestionarPracticantesState();
}

class _VistaGestionarPracticantesState extends State<VistaGestionarPracticantes> {
  
  Practicante practicante = new Practicante();
  
  crearPacienteTemporal(){
    practicante.nombre = 'Pepito';
    practicante.apellido = 'Gómez';
    practicante.tipoDocumento = 'Tarjeta de Identidad';
    practicante.documento = '1234567';
    practicante.email = 'pepito@gmail.com';
    practicante.telefono = '32324214';
    practicante.direccion = 'Calle 23 # 44-20';
    practicante.activo = true;
    practicante.enfoque = 'Sistemico';
    practicante.pregrado = true;
    practicante.semestre = 10;
  }

  @override
  void initState() { 
    crearPacienteTemporal();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    print(practicante.nombre);
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
                showDialog(context: context, builder: (context) => DialogoCrearPracticante(practicante: practicante));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              color: kPrimaryColor,

              onPressed: () {
                showDialog(context: context, builder: (context) => DialogoEditarPracticante(practicante: practicante));
              },
            ),

            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              color: kPrimaryColor,

              onPressed: () {
                showDialog(context: context, builder: (context) => DialogoVisualizarPracticante(practicante: practicante));
              },
            ),
         ],
      ),
    );
  }
}
