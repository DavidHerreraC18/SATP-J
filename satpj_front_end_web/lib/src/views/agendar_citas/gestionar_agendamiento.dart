import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/sesion_notifier.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Calendarios/CalendarioAgendar.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_sesiones_terapia.dart';
import 'package:satpj_front_end_web/src/utils/widgets/LoadingWidgets/LoadingWanderingCube.dart';
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
  Paciente paciente;
  Practicante practicante;

  @override
  void initState() {
    super.initState();
  }

  Future<String> obtenerInfoPacientePracticante() async {
    String uid = ProviderAuntenticacion.uid;
    paciente = await ProviderAdministracionPacientes.buscarPaciente(uid);
    practicante =
        await ProviderAdministracionPacientes.traerPracticanteActivoPaciente(
            paciente);
    return Future.value("Data download successfully");
    //crearPacienteTemporal();
    //crearSesionTemporal();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future:
          obtenerInfoPacientePracticante(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            final Map arguments =
                ModalRoute.of(context).settings.arguments as Map;

            if (arguments != null) {
              paciente = arguments['arguments'] as Paciente;
            }

            print(paciente.nombre);
            return Scaffold(
              appBar: toolbarAuxiliarAdministrativo(context),
              body: ChangeNotifierProvider<SesionNotifier>(
                create: (_) => SesionNotifier(),
                child: _InternalWidget(
                  paciente: this.paciente,
                  practicante: this.practicante,
                ),
              ),
            );
          }
        }
      },
    );
  }
}

class _InternalWidget extends StatelessWidget {
  const _InternalWidget({this.paciente, this.practicante, Key key})
      : super(key: key);

  final Paciente paciente;
  final Practicante practicante;

  @override
  Widget build(BuildContext context) {
    //
    final _provider = context.watch<SesionNotifier>();
    final _model = _provider.sesion;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
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

  void _showEditDialog(BuildContext c, SesionTerapia data) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) => DialogoAgendarSesionTerapia(
                paciente: paciente,
                sesion: data,
                labelConfirmBtn: 'Editar',
              ));

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
