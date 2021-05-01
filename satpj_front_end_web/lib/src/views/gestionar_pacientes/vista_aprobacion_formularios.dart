import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/formulario_notifier.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialogo_aprobacion.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialogo_preaprobacion.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_formulario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_formulario_extra.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';

class VistaAprobacionFormularios extends StatelessWidget {
  static const route = '/preaprobar-pacientes';

  @override
  VistaAprobacionFormulariosState createState() =>
      VistaAprobacionFormulariosState();
}

class VistaAprobacionFormulariosState
    extends State<VistaAprobacionFormularios> {
  bool estado = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: Column(
        children: [
          LiteRollingSwitch(
            //initial value
            value: estado,
            textOn: 'Pendientes Aprobación',
            textOff: 'Pre-Aprobados',
            colorOn: kPrimaryColor,
            colorOff: kAccentColor,
            iconOn: Icons.accessibility_new,
            iconOff: Icons.attribution_outlined,
            textSize: 13.0,
            onChanged: (bool state) {
              //Use it to manage the different states
              setState(() {
                estado = state;
              });
            },
          ),
          estado
              ? Expanded(
                  child: Container(
                    child: ChangeNotifierProvider<FormularioNotifier>(
                      create: (_) => FormularioNotifier(),
                      child: _InternalWidgetPreAprob(),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    child: ChangeNotifierProvider<FormularioExtraNotifier>(
                      create: (_) => FormularioExtraNotifier(),
                      child: _InternalWidgetAprob(),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class _InternalWidgetPreAprob extends StatelessWidget {
  const _InternalWidgetPreAprob({Key key}) : super(key: key);

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
            "Documento",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          numeric: true,
          tooltip: "Documento del paciente",
        ),
        DataColumn(
          label: Text(
            "Tipo",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Tipo de Documento del paciente",
          onSort: (colIndex, asc) {
            _sort<String>((formulario) => formulario.paciente.tipoDocumento,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Nombre",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Nombre del paciente",
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
          tooltip: "Apellido del paciente",
          onSort: (colIndex, asc) {
            _sort<String>((formulario) => formulario.paciente.apellido,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Teléfono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Teléfono del paciente",
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
            "Formulario",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Formulario llenado por el paciente",
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

  void _showDetails(BuildContext c, Formulario data) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) => PreAprobDialog(formularioSeleccionado: data));
}

class _InternalWidgetAprob extends StatelessWidget {
  const _InternalWidgetAprob({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final _provider = context.watch<FormularioExtraNotifier>();
    final _model = _provider.formulario;

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = FormularioExtraDataTableSource(
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
    FormularioExtraDataTableSource _src,
    FormularioExtraNotifier _provider,
    BuildContext context,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Documento",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          numeric: true,
          tooltip: "Documento del paciente",
        ),
        DataColumn(
          label: Text(
            "Tipo",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Tipo de Documento del paciente",
          onSort: (colIndex, asc) {
            _sort<String>((formulario) => formulario.paciente.tipoDocumento,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Nombre",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Nombre del paciente",
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
          tooltip: "Apellido del paciente",
          onSort: (colIndex, asc) {
            _sort<String>((formulario) => formulario.paciente.apellido,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Teléfono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Teléfono del paciente",
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
            "Formulario",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Formulario llenado por el paciente",
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(FormularioExtra formulario) getField,
    int colIndex,
    bool asc,
    FormularioExtraDataTableSource _src,
    FormularioExtraNotifier _provider,
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

  void _showDetails(BuildContext c, FormularioExtra data) async =>
      await showDialog<bool>(
          context: c,
          /*builder: (_) => CustomDialog(
          showPadding: false,
          child: OtherDetails(data: data),
        ),*/
          builder: (_) => AprobDialog(formularioSeleccionado: data));
}
