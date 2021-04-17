import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/views/agendar_citas/dialogo_sesion_terapia.dart';

class VistaGestionarAgendamiento extends StatefulWidget {
  static const route = '/gestionar-agendamiento';

  VistaGestionarAgendamiento();

  @override
  _VistaGestionarAgendamientoState createState() =>
      _VistaGestionarAgendamientoState();
}

class _VistaGestionarAgendamientoState
    extends State<VistaGestionarAgendamiento> {
  Paciente paciente = new Paciente();
  SesionTerapia sesion = new SesionTerapia();

  crearPacienteTemporal() {
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

  crearSesionTemporal() {
    sesion.fecha = new DateTime.now();
    sesion.hora = new DateTime.now();
    sesion.consultorio = 'Tarjeta de Identidad';
    sesion.virtual = true;
  }

  @override
  void initState() {
    crearPacienteTemporal();
    crearSesionTemporal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      paciente = arguments['arguments'] as Paciente;
    }

    print(paciente.nombre);
    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: Container(
        margin: EdgeInsets.all(40.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Sesiones de Terapia ' + paciente.nombre + ' ' + paciente.apellido,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => DialogoAgendarSesionTerapia(
                        paciente: paciente,
                      ));
            },
            child: Text(
              'Crear Sesión',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: kPrimaryColor,
                ),
                color: kPrimaryColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DialogoAgendarSesionTerapia(
                            paciente: paciente,
                            sesion: sesion,
                          ));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_rounded,
                  color: kPrimaryColor,
                ),
                color: kPrimaryColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DialogDelete(
                        label: '¿Esta seguro que desea eliminar la sesión de terapia?',
                        labelCancelBtn: 'No',
                        labelConfirmBtn: 'Si',
                        colorConfirmBtn: Theme.of(context).colorScheme.error,
                        labelHeader: 'Eliminar Sesión de Terapia',
                      )
                  );
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
