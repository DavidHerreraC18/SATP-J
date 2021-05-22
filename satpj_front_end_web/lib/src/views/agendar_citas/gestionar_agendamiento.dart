import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satpj_front_end_web/src/model/consultorio/consultorio.dart';
import 'package:satpj_front_end_web/src/model/notificadores/sesion_notifier.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_consultorios.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Calendarios/CalendarioAgendar.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/fuentes_datos/datatablesource_sesiones_terapia.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/views/agendar_citas/dialogo_sesion_terapia.dart';
import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';

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
  Practicante practicante;
  List<Consultorio> consultorios;

  @override
  void initState() {
    paciente = new Paciente();
    super.initState();
  }

  Future<String> obtenerInfoPacientePracticante() async {
    practicante =
        await ProviderAdministracionPacientes.traerPracticanteActivoPaciente(
            paciente.id);
    consultorios = await ProviderAdministracionConsultorios.traerConsultorios();
    return Future.value("Data download successfully");
    //crearPacienteTemporal();
    //crearSesionTemporal();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      if (arguments['arguments'] is Paciente) {
        print(arguments['arguments']);
        paciente = arguments['arguments'] as Paciente;
      }
    }
    Dialog dialogoError = new Dialog(
        child: Column(
      children: [
        HeaderDialog(
          label: 'Error',
        ),
        Text("Para agendar una cita debe asignar un practicante al paciente"),
        FotterDialog(
          labelConfirmBtn: 'Aceptar',
          colorConfirmBtn: kPrimaryColor,
          width: 120.0,
        )
      ],
    ));
    return FutureBuilder<String>(
      future:
          obtenerInfoPacientePracticante(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError) {
            showDialog(context: context, builder: (context) => dialogoError);
            return SizedBox.shrink();
          } else {
            final Map arguments =
                ModalRoute.of(context).settings.arguments as Map;

            if (arguments != null) {
              paciente = arguments['arguments'] as Paciente;
            }

            print(paciente.nombre);
            return Scaffold(
              appBar: toolbarAuxiliarAdministrativo(context),
              body: ChangeNotifierProvider<SesionNotifier>(
                create: (_) => SesionNotifier(paciente: this.paciente),
                child: _InternalWidget(
                    paciente: this.paciente,
                    practicante: this.practicante,
                    consultorios: this.consultorios),
              ),
            );
          }
        }
      },
    );
  }
}

class _InternalWidget extends StatelessWidget {
  const _InternalWidget(
      {this.paciente, this.practicante, this.consultorios, Key key})
      : super(key: key);

  final Paciente paciente;
  final Practicante practicante;
  final List<Consultorio> consultorios;

  @override
  Widget build(BuildContext context) {
    //
    final _provider = context.watch<SesionNotifier>();
    final _model = _provider.sesion;

    if (_model.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "El Paciente no tiene sesiones de terapia actualmente",
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " Haga clic para crear una",
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(
                height: 10,
              ),
              Ink(
                decoration: const ShapeDecoration(
                  color: Color(0xFF2E5EAA),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => CalendarioAgendar(
                            paciente: paciente, practicante: practicante));
                  },
                ),
              ),
            ],
          ),
        ],
      );
    }
    final _dtSource = SesionesTerapiaDataTableSource(
      onRowSelectEdit: (index) => _showEditDialog(context, _model[index]),
      onRowSelectDelete: (index) => _showDeleteDialog(context, _model[index]),
      //onRowSelect: (index) {},
      sesiones: _model,
    );

    return CustomPaginatedTable(
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: kPrimaryColor,
          ),
          color: kPrimaryColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => CalendarioAgendar(
                    paciente: paciente, practicante: practicante));
          },
        ),
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          //splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData(paciente.id);
            //_showSBar(context, DataTableConstants.refresh);
          },
        ),
      ],
      dataColumns: _colGen(_dtSource, _provider, context),
      header: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Sesiones de Terapia ' + paciente.nombre + ' ' + paciente.apellido,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ]),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: 10,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    SesionesTerapiaDataTableSource _src,
    SesionNotifier _provider,
    BuildContext context,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Fecha",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Fecha de la sesión de terapia",
        ),
        DataColumn(
          label: Text(
            "Hora",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Hora de la sesión de terapia",
          onSort: (colIndex, asc) {
            _sort<String>((sesion) => DateFormat.Hms().format(sesion.fecha),
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Modalidad",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Modalidad de la sesiónd de terapia",
          onSort: (colIndex, asc) {
            _sort<String>((sesion) => sesion.virtual.toString(), colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Consultorio",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Consultorio de la sesión de terapia",
          onSort: (colIndex, asc) {
            _sort<String>((sesion) => sesion.consultorio.consultorio, colIndex,
                asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Acciones",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Acciones",
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(SesionTerapia sesionTerapia) getField,
    int colIndex,
    bool asc,
    SesionesTerapiaDataTableSource _src,
    SesionNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  /*void _showSBar(BuildContext c, String textToShow) {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        content: Text(textToShow),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }*/

  void _showEditDialog(BuildContext c, SesionTerapia data) async {
    await showDialog<bool>(
        context: c,
        builder: (_) => DialogoAgendarSesionTerapia(
              pacienteSesion: paciente,
              practicanteAsignado: practicante,
              sesionTerapia: data,
              consultorios: consultorios,
              labelConfirmBtn: 'Editar',
            ));
  }

  void _showDeleteDialog(BuildContext c, SesionTerapia data) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) => DialogDelete(
                label: '¿Esta seguro que desea eliminar la sesión de terapia?',
                labelCancelBtn: 'No',
                labelConfirmBtn: 'Si',
                colorConfirmBtn: Theme.of(c).colorScheme.error,
                labelHeader: 'Eliminar Sesión de Terapia',
              ));
}
