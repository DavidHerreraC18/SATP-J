import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/comprobante_notifier.dart';
import 'package:satpj_front_end_web/src/model/comprobante_pago/comprobante_pago.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion/paquete_sesion.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/FuentesDatos/datatablesource_comprobantes_pagos.dart';
import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/utils/widgets/LoadingWidgets/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/custom_paginated_datatable.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/dialogo_visualizar_paciente.dart';

class VistaVisualizarPagos extends StatefulWidget {
  static const route = '/visualizar-pagos';

  VistaVisualizarPagos();

  @override
  _VistaVisualizarPagosState createState() => _VistaVisualizarPagosState();
}

Paciente paciente = new Paciente();
List<ComprobantePago> comprobantes = [];

class _VistaVisualizarPagosState extends State<VistaVisualizarPagos> {
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

  crearComprobanteTemporal() {
    ComprobantePago comprobantePago = new ComprobantePago();
    comprobantePago.fecha = DateTime.now();
    comprobantePago.referenciaPago = "2020202";
    comprobantePago.observacion = "Sesión de Terapia";
    comprobantePago.valorTotal = 20.000;
    comprobantePago.paqueteSesion = new PaqueteSesion();
    comprobantePago.paqueteSesion.paciente = paciente;
    comprobantes.add(comprobantePago);
  }

  @override
  void initState() {
    crearPacienteTemporal();
    crearComprobanteTemporal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarAuxiliarAdministrativo(context),
      body: ChangeNotifierProvider<ComprobanteNotifier>(
        create: (_) => ComprobanteNotifier(),
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
    final _provider = context.watch<ComprobanteNotifier>();
    final _model = _provider.comprobante;
    //final _model = comprobantes;

    if (_model.isEmpty) {
      return LoadingWanderingCube();
    }
    final _dtSource = ComprobantesPagosDataTableSource(
      onRowSelectView: (index) => _showViewDialog(context, _model[index]),
      comprobantes: _model,
    );

    return CustomPaginatedTable(
      actions: [
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
          'Comprobantes de Pago:  Sesiones de Terapia ',
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
    ComprobantesPagosDataTableSource _src,
    ComprobanteNotifier _provider,
    BuildContext context,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Fecha",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Fecha",
        ),
        DataColumn(
          label: Text(
            "Paciente",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Paciente",
          onSort: (colIndex, asc) {
            _sort<String>(
                (comprobante) =>
                    comprobante.paqueteSesion.paciente.nombre.toString(),
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
                (comprobante) => comprobante.paqueteSesion.paciente.documento,
                colIndex,
                asc,
                _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Estrato",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Estrato del paciente",
          onSort: (colIndex, asc) {
            _sort<String>(
                (comprobante) =>
                    comprobante.paqueteSesion.paciente.estrato.toString(),
                colIndex,
                asc,
                _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Referencia de Pago",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Referencia de pago",
          onSort: (colIndex, asc) {
            _sort<String>((comprobante) => comprobante.referenciaPago, colIndex,
                asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Sesiones de Terapia",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Cantidad Sesiones de terapia",
          onSort: (colIndex, asc) {
            _sort<String>(
                (comprobante) =>
                    comprobante.paqueteSesion.cantidadSesiones.toString(),
                colIndex,
                asc,
                _src,
                _provider);
          },
        ),
        DataColumn(
          label: Text(
            "Valor Total ",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          tooltip: "Valor total del pago",
          onSort: (colIndex, asc) {
            _sort<String>((comprobante) => comprobante.valorTotal.toString(),
                colIndex, asc, _src, _provider);
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
    Comparable<T> Function(ComprobantePago comprobantePago) getField,
    int colIndex,
    bool asc,
    ComprobantesPagosDataTableSource _src,
    ComprobanteNotifier _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _showViewDialog(BuildContext c, ComprobantePago data) async =>
      await showDialog<bool>(
          context: c,
          builder: (_) => DialogoVisualizarPaciente(paciente: paciente));
}
