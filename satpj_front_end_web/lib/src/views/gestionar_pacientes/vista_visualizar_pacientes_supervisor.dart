import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/notificadores/pacientes_notifier.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_supervisor.dart';
import 'package:satpj_front_end_web/src/utils/widgets/fuentes_datos/datatablesource_pacientes_visualizar.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/dialogo_visualizar_paciente.dart';

class VistaVisualizarPacientesSupervisor extends StatelessWidget {
  static const route = '/visualizar-pacientes-supervisor';

  const VistaVisualizarPacientesSupervisor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = ProviderAuntenticacion.uid;
    return Scaffold(
      appBar: toolbarSupervisor(context),
      body: Column(
        children: [
          Expanded(
            child: ChangeNotifierProvider<PacienteNotifier>(
              create: (_) => PacienteNotifier(2, uid: uid),
              child: _InternalWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class _InternalWidget extends StatelessWidget {
  const _InternalWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final _provider = context.watch<PacienteNotifier>();
    final _model = _provider.paciente;

    if (_model.isEmpty) {
      return LoadingWanderingCube();
    }
    final _dtSource = PacientesVisualizarDataTableSource(
      onRowSelectDetail: (index) => _details(context, _model[index]),
      pacientes: _model,
    );

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          //splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData(2);
            //_showSBar(context, DataTableConstants.refresh);
          },
        ),
      ],
      dataColumns: _colGen(_dtSource, _provider, context),
      header: const Text(
        "Lista de Pacientes",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: 10,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    PacientesVisualizarDataTableSource _src,
    PacienteNotifier _provider,
    BuildContext context,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Nombre",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          numeric: true,
          tooltip: "Nombre del paciente",
          onSort: (colIndex, asc) {
            _sort<String>(
                (paciente) => paciente.nombre, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Apellido",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Apellido del paciente",
          onSort: (colIndex, asc) {
            _sort<String>((paciente) => paciente.apellido, colIndex, asc, _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Documento",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Documento del paciente",
          onSort: (colIndex, asc) {
            _sort<String>((paciente) => paciente.documento, colIndex, asc, _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Email",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Correo electrónico del paciente",
          onSort: (colIndex, asc) {
            _sort<String>(
                (paciente) => paciente.email, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Teléfono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Teléfono del paciente",
          onSort: (colIndex, asc) {
            _sort<String>((paciente) => paciente.telefono, colIndex, asc, _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Edad",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Edad del paciente",
          onSort: (colIndex, asc) {
            _sort<String>((paciente) => paciente.edad.toString(), colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Acciones",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Acciones que se pueden hacer con el paciente",
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Paciente paciente) getField,
    int colIndex,
    bool asc,
    PacientesVisualizarDataTableSource _src,
    PacienteNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _details(BuildContext c, Paciente data) async => await showDialog<bool>(
      context: c, builder: (_) => DialogoVisualizarPaciente(paciente: data));
}
