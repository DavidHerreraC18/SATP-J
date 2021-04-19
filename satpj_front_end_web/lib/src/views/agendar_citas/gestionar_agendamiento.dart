import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/sesion_notifier.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_sesiones_terapia.dart';
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

Paciente paciente = new Paciente();
SesionTerapia sesion = new SesionTerapia();

class _VistaGestionarAgendamientoState
    extends State<VistaGestionarAgendamiento> {
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
      body: ChangeNotifierProvider<SesionNotifier>(
        create: (_) => SesionNotifier(),
        child: _InternalWidget(),
      ),
    );
  }
}

class _InternalWidget extends StatelessWidget {
  const _InternalWidget({Key key}) : super(key: key);

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
                builder: (context) => DialogoAgendarSesionTerapia(
                      paciente: paciente,
                    ));
          },
        ),
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          //splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData();
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
            _sort<String>((sesion) => sesion.hora.toString(), colIndex, asc,
                _src, _provider);
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
            _sort<String>(
                (sesion) => sesion.consultorio, colIndex, asc, _src, _provider);
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
