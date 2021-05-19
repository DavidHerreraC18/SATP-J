import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/practicantes_horas_notifier.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante_horas.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_practicantes_horas.dart';
import 'package:satpj_front_end_web/src/utils/widgets/LoadingWidgets/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/pdf_certificado_horas.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';

class VistaAdministrarCertificados extends StatelessWidget {
  static const route = '/administrar_certificados';
  const VistaAdministrarCertificados({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: Column(
        children: [
          Expanded(
            child: ChangeNotifierProvider<PracticanteHorasNotifier>(
              create: (_) => PracticanteHorasNotifier(),
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
    final _provider = context.watch<PracticanteHorasNotifier>();
    final _model = _provider.practicante;

    if (_model.isEmpty) {
      return LoadingWanderingCube();
    }
    final _dtSource = PracticantesHorasDataTableSource(
      onRowSelectCertificate: (index) => _certificate(context, _model[index]),
      practicantes: _model,
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
      header: const Text(
        "Lista de practicantes del sistema",
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
    PracticantesHorasDataTableSource _src,
    PracticanteHorasNotifier _provider,
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
            _sort<String>((practicante) => practicante.practicante.nombre,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Apellido",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Apellido del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.practicante.apellido,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Documento",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Documento del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.practicante.documento,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Email",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Correo electrónico del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.practicante.email,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Teléfono",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Teléfono del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.practicante.telefono,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Enfoque",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Enfoque del practicante",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.practicante.enfoque,
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Horas",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Horas de trabajo",
          onSort: (colIndex, asc) {
            _sort<String>((practicante) => practicante.horas.toString(),
                colIndex, asc, _src, _provider);
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
    Comparable<T> Function(PracticanteHoras practicante) getField,
    int colIndex,
    bool asc,
    PracticantesHorasDataTableSource _src,
    PracticanteHorasNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _certificate(BuildContext c, PracticanteHoras data) async {
    PdfCertificadoHoras pdf = new PdfCertificadoHoras();
    pdf.createCertificate(data);
  }
}
