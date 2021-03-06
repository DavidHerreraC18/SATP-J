import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_practicantes.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_supervisores.dart';

class PracticanteNotifier with ChangeNotifier {
  final String uid;
  PracticanteNotifier(int usuario, {this.uid}) {
    fetchData(usuario);
  }

  List<Practicante> get practicante => _practicante;

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

  var _practicante = <Practicante>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData(int usuario) async {
    if (usuario == 1) {
      //Auxiliar
      _practicante =
          await ProviderAdministracionPracticantes.traerPracticantes();
    } else if (usuario == 2) {
      //Supervisor
      _practicante =
          await ProviderAdministracionSupervisores.traerPracticantesSupervisor(
              this.uid);
    }
    notifyListeners();
  }
}
