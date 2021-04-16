import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/formulario_notifier.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/pacientes_notifier.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialogo_preaprobacion.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_formulario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/dialogo_crear_paciente.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/dialogo_editar_paciente.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/dialogo_visualizar_paciente.dart';

class VistaAdministrarPacientes extends StatelessWidget {
  static const route = '/administrar-pacientes';

  const VistaAdministrarPacientes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: ChangeNotifierProvider<PacienteNotifier>(
        create: (_) => PacienteNotifier(),
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
    final _provider = context.watch<PacienteNotifier>();
    final _model = _provider.paciente;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = PacientesDataTableSource(
      onRowSelectDetail: (index) => _details(context, _model[index]),
      onRowSelectEdit: (index) => _edit(context, _model[index]),
      onRowSelectDelete: (index) => _delete(context, _model[index]),
      pacientes: _model,
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
      header: const Text("Lista de pacientes del sistema"),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: 10,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    PacientesDataTableSource _src,
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
        ),
        DataColumn(
          label: Text(
            "Email",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Correo electrónico del paciente",
        ),
        DataColumn(
          label: Text(
            "Telefono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Telefono del paciente",
        ),
        DataColumn(
          label: Text(
            "Dirección",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Dirección del paciente",
        ),
        DataColumn(
          label: Text(
            "Edad",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Edad del paciente",
        ),
        /*DataColumn(
          label: Text(
            "Estrato",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Estrato del paciente",
        ),
        DataColumn(
          label: Text(
            "Remitido",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Si fue o no remitido el paciente",
        ),*/
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
    PacientesDataTableSource _src,
    PacienteNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _details(BuildContext c, Paciente data) async => await showDialog<bool>(
      context: c,
      builder: (_) => DialogoVisualizarPaciente(pacienteSeleccionado: data));

  void _edit(BuildContext c, Paciente data) async => await showDialog<bool>(
      context: c,
      builder: (_) => DialogoEditarPaciente(pacienteSeleccionado: data));

  void _delete(BuildContext c, Paciente data) async =>
      await showDialog<bool>(context: c, builder: (_) => DialogDelete());

  void _create(BuildContext c) async => await showDialog<bool>(
      context: c, builder: (_) => DialogoCrearPaciente());
}
