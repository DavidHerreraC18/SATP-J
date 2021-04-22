import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/supervisores_notifier.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_supervisores.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores.dart/dialogo_crear_supervisor.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores.dart/dialogo_editar_supervisor.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores.dart/dialogo_visualizar_supervisor.dart';

class VistaAdministrarSupervisores extends StatelessWidget {
  static const route = '/administrar-supervisores';

  const VistaAdministrarSupervisores({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: ChangeNotifierProvider<SupervisorNotifier>(
        create: (_) => SupervisorNotifier(),
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
    final _provider = context.watch<SupervisorNotifier>();
    final _model = _provider.supervisor;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = SupervisoresDataTableSource(
      onRowSelectDetail: (index) => _details(context, _model[index]),
      onRowSelectEdit: (index) => _edit(context, _model[index]),
      onRowSelectDelete: (index) => _delete(context, _model[index]),
      supervisores: _model,
    );

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          //splashColor: Colors.transparent,
          icon: const Icon(Icons.add),
          onPressed: () {
            _create(context);
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
      header: const Text("Lista de supervisores del sistema"),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: 10,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    SupervisoresDataTableSource _src,
    SupervisorNotifier _provider,
    BuildContext context,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Nombre",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          numeric: true,
          tooltip: "Nombre del supervisor",
          onSort: (colIndex, asc) {
            _sort<String>((supervisor) => supervisor.nombre, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Apellido",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Apellido del supervisor",
          onSort: (colIndex, asc) {
            _sort<String>((supervisor) => supervisor.apellido, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Documento",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Documento del supervisor",
          onSort: (colIndex, asc) {
            _sort<String>((supervisor) => supervisor.documento, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Email",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Correo electrónico del supervisor",
          onSort: (colIndex, asc) {
            _sort<String>((supervisor) => supervisor.email, colIndex, asc, _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Telefono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Telefono del supervisor",
          onSort: (colIndex, asc) {
            _sort<String>((supervisor) => supervisor.telefono, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Enfoque",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Enfoque del supervisor",
          onSort: (colIndex, asc) {
            _sort<String>((supervisor) => supervisor.enfoque, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Acciones",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Acciones que se pueden hacer con el supervisor",
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Supervisor supervisor) getField,
    int colIndex,
    bool asc,
    SupervisoresDataTableSource _src,
    SupervisorNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _details(BuildContext c, Supervisor data) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) => DialogoVisualizarSupervisor(supervisor: data));

  void _edit(BuildContext c, Supervisor data) async => await showDialog<bool>(
      context: c, builder: (_) => DialogoEditarSupervisor(supervisor: data));

  void _delete(BuildContext c, Supervisor data) async => await showDialog<bool>(
      context: c,
      builder: (_) => DialogDelete(
            labelHeader: 'Eliminar Supervisor',
            label: '¿Esta seguro de que desea eliminar el supervisor?',
            labelCancelBtn: 'Cancelar',
            labelConfirmBtn: 'Confirmar',
            colorConfirmBtn: Theme.of(c).colorScheme.primary,
          ));

  void _create(BuildContext c) async => await showDialog<bool>(
      context: c,
      builder: (_) => DialogoCrearSupervisor(
            supervisor: new Supervisor(),
          ));
}
