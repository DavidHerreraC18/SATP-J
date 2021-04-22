import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/practicantes_notifier.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_practicantes.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/dialogo_crear_practicante.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/dialogo_editar_practicante.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/dialogo_visualizar_practicante.dart';

class VistaAdministrarPracticantes extends StatelessWidget {
  static const route = '/administrar-practicantes';

  const VistaAdministrarPracticantes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: ChangeNotifierProvider<PracticanteNotifier>(
        create: (_) => PracticanteNotifier(),
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
    final _provider = context.watch<PracticanteNotifier>();
    final _model = _provider.practicante;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = PracticantesDataTableSource(
      onRowSelectDetail: (index) => _details(context, _model[index]),
      onRowSelectEdit: (index) => _edit(context, _model[index]),
      onRowSelectDelete: (index) => _delete(context, _model[index]),
      practicantes: _model,
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
      header: const Text("Lista de practicantes del sistema"),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: 10,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    PracticantesDataTableSource _src,
    PracticanteNotifier _provider,
    BuildContext context,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Nombre",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          numeric: true,
          tooltip: "Nombre del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.nombre, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Apellido",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Apellido del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.apellido, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Documento",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Documento del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.documento, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Email",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Correo electrónico del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.email, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Telefono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Telefono del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.telefono, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Enfoque",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Enfoque del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.enfoque, colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Acciones",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Acciones que se pueden hacer con el practicante",
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Practicante practicante) getField,
    int colIndex,
    bool asc,
    PracticantesDataTableSource _src,
    PracticanteNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _details(BuildContext c, Practicante data) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) =>
              DialogoVisualizarPracticante(/*practicanteSeleccionado: data*/));

  void _edit(BuildContext c, Practicante data) async => await showDialog<bool>(
      context: c,
      builder: (_) =>
          DialogoEditarPracticante(/*practicanteSeleccionado: data*/));

  void _delete(BuildContext c, Practicante data) async =>
      await showDialog<bool>(context: c, builder: (_) => DialogDelete());

  void _create(BuildContext c) async => await showDialog<bool>(
      context: c, builder: (_) => DialogoCrearPracticante());
}
