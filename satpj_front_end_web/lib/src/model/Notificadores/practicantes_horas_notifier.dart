import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:satpj_front_end_web/src/model/practicante/practicante_horas.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_practicantes.dart';

class PracticanteHorasNotifier with ChangeNotifier {
  PracticanteHorasNotifier() {
    fetchData();
  }

  List<PracticanteHoras> get practicante => _practicante;

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

  var _practicante = <PracticanteHoras>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    _practicante =
        await ProviderAdministracionPracticantes.traerPracticantesHoras();
    notifyListeners();
  }
}
