import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_practicantes.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_supervisores.dart';

class PacienteNotifier with ChangeNotifier {
  final String uid;
  PacienteNotifier(int total, {this.uid}) {
    fetchData(total);
  }

  List<Paciente> get paciente => _paciente;

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

  var _paciente = <Paciente>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData(int total) async {
    if (total == 1) {
      _paciente = await ProviderAdministracionPacientes.traerPacientes();
    } else if (total == 2) {
      //Supervisor
      _paciente =
          await ProviderAdministracionSupervisores.traerPacientesSupervisor(
              this.uid);
    } else if (total == 3) {
      //Practicante
      _paciente = await ProviderAdministracionPracticantes
          .traerPacientesActivosPracticante(this.uid);
    }
    notifyListeners();
  }
}
