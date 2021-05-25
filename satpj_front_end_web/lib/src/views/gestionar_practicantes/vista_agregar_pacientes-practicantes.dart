import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/notificadores/paciente-practicante_notifier.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante_paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_agregar_pacientes-practicantes.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/fuentes_datos/datatablesource_pacientes-practicantes.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/dialogo_visualizar_paciente.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/dialogo_agregar_paciente-practicante.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_administrar_practicantes.dart';

class VistaAgregarPacientesPracticantes extends StatelessWidget {
  static const route = '/agregar-pacientes-practicantes';

  const VistaAgregarPacientesPracticantes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Practicante practicante = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Future.delayed(Duration(milliseconds: 1000), () {
                  Navigator.of(context)
                      .pushNamed(VistaAdministrarPracticantes.route);
                });
              }),
          Expanded(
            child: ChangeNotifierProvider<PacientePracticanteNotifier>(
              create: (_) => PacientePracticanteNotifier(practicante.id),
              child: _InternalWidget(practicante),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _InternalWidget extends StatelessWidget {
  Practicante practicante;
  _InternalWidget(this.practicante, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //
    final _provider = context.watch<PacientePracticanteNotifier>();
    final _model = _provider.practicantepaciente;

    if (_model.isEmpty) {
      return LoadingWanderingCube();
    }
    final _dtSource = PacientesPracticantesDataTableSource(
      onRowSelectDetail: (index) => _details(context, _model[index]),
      onRowSelectDelete: (index) => _delete(context, _model[index]),
      practicantepacientes: _model,
    );

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          //splashColor: Colors.transparent,
          icon: const Icon(Icons.add),
          onPressed: () {
            _create(context, practicante);
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
      header: const Text(
        "Lista de Pacientes Asignados al Practicante",
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
    PacientesPracticantesDataTableSource _src,
    PacientePracticanteNotifier _provider,
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
                (pacientepracticante) => pacientepracticante.paciente.nombre,
                colIndex,
                asc,
                _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Apellido",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Apellido del paciente",
          onSort: (colIndex, asc) {
            _sort<String>(
                (pacientepracticante) => pacientepracticante.paciente.apellido,
                colIndex,
                asc,
                _src,
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
            _sort<String>(
                (pacientepracticante) => pacientepracticante.paciente.documento,
                colIndex,
                asc,
                _src,
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
                (pacientepracticante) => pacientepracticante.paciente.email,
                colIndex,
                asc,
                _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Teléfono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Teléfono del paciente",
          onSort: (colIndex, asc) {
            _sort<String>(
                (pacientepracticante) => pacientepracticante.paciente.telefono,
                colIndex,
                asc,
                _src,
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
            _sort<String>(
                (pacientepracticante) =>
                    pacientepracticante.paciente.edad.toString(),
                colIndex,
                asc,
                _src,
                _provider);
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
    Comparable<T> Function(PracticantePaciente practicantePaciente) getField,
    int colIndex,
    bool asc,
    PacientesPracticantesDataTableSource _src,
    PacientePracticanteNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _details(BuildContext c, PracticantePaciente data) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) => DialogoVisualizarPaciente(paciente: data.paciente));

  void _delete(BuildContext c, PracticantePaciente data) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) => DialogDelete(
                labelHeader: 'Desasociar paciente',
                label: '¿Esta seguro de que desea eliminar el practicante?',
                labelCancelBtn: 'Cancelar',
                labelConfirmBtn: 'Confirmar',
                colorConfirmBtn: Theme.of(c).colorScheme.error,
                functionDelete: () {
                  print(ProviderAgregarPracticantesPacientes
                      .borrarPracticantePaciente(
                          data.practicante.id, data.paciente.id));
                  Future.delayed(Duration(milliseconds: 1000), () {
                    Navigator.of(c).pushNamed(
                        VistaAgregarPacientesPracticantes.route,
                        arguments: data.practicante);
                  });
                },
              ));

  void _create(BuildContext c, Practicante practicante) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) =>
              DialogoAgregarPacientePracticante(practicante: practicante));
}
