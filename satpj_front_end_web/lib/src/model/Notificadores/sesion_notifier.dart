import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_sesiones_terapia.dart';

class SesionNotifier with ChangeNotifier {
  SesionNotifier({this.paciente}) {
    fetchData(this.paciente.id);
  }
  Paciente paciente;
  List<SesionTerapia> get sesion => _sesion;

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

  var _sesion = <SesionTerapia>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData(String usuarioId) async {
    _sesion.clear();
    List<SesionUsuario> sesionUsuario =
        await ProviderSesionesTerapia.obtenerSesionesUsuario(usuarioId);
    for (int i = 0; i < sesionUsuario.length; i++) {
      _sesion.add(sesionUsuario[i].sesionTerapia);
    }
    notifyListeners();
  }
}
