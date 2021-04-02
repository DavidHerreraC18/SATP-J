import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/data_notifier.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialogo_preaprobacion.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_formulario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';

class VistaAprobacionPacientes extends StatelessWidget {
  const VistaAprobacionPacientes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: ChangeNotifierProvider<FormularioNotifier>(
        create: (_) => FormularioNotifier(),
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
    final _provider = context.watch<FormularioNotifier>();
    final _model = _provider.formulario;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = FormularioDataTableSource(
      onRowSelect: (index) => _showDetails(context, _model[index]),
      //onRowSelect: (index) {},
      formularios: _model,
    );

    return CustomPaginatedTable(
      actions: <IconButton>[
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
      header: const Text("Lista de usuarios pendientes de aprobacion"),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: 10,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  List<DataColumn> _colGen(
    FormularioDataTableSource _src,
    FormularioNotifier _provider,
    BuildContext context,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "ID",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          numeric: true,
          tooltip: "ID",
        ),
        DataColumn(
          label: Text(
            "Nombre",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Nombre",
          onSort: (colIndex, asc) {
            _sort<String>((formulario) => formulario.paciente.nombre, colIndex,
                asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Apellido",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Apellido",
          onSort: (colIndex, asc) {
            _sort<String>((formulario) => formulario.paciente.apellido,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Telefono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Telefono",
        ),
        DataColumn(
          label: Text(
            "Email",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Email",
        ),
        DataColumn(
          label: Text(
            "Formulario",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Formulario",
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Formulario formulario) getField,
    int colIndex,
    bool asc,
    FormularioDataTableSource _src,
    FormularioNotifier _provider,
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

  void _showDetails(BuildContext c, Formulario data) async => await showDialog<
          bool>(
      context: c,
      /*builder: (_) => CustomDialog(
          showPadding: false,
          child: OtherDetails(data: data),
        ),*/
      builder: (_) => PreAprobDialog(formularioSeleccionado: data));
}