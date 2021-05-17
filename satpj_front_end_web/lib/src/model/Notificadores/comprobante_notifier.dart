import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/comprobante_pago/comprobante_pago.dart';
import 'package:satpj_front_end_web/src/providers/provider_pagos.dart';

class ComprobanteNotifier with ChangeNotifier {
  ComprobanteNotifier() {
    fetchData();
  }

  List<ComprobantePago> get comprobante => _comprobante;

  // SORT COLUMN INDEX...

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  // -------------------------------------- INTERNALS --------------------------------------------

  var _comprobante = <ComprobantePago>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    _comprobante = await ProviderGestionPagos.obtenerComprobantesPagosPacientes();
    notifyListeners();
  }
}