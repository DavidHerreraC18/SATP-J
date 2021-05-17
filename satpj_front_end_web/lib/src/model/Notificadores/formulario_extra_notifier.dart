import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_aprobacion_pacientes.dart';

class FormularioExtraNotifier with ChangeNotifier {
  FormularioExtraNotifier() {
    fetchData();
  }
  List<FormularioExtra> get formulario => _formulario;

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

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

  var _formulario = <FormularioExtra>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    _formulario =
        await ProviderAprobacionPacientes.traerFormulariosExtrasPreAprobados();
    notifyListeners();
  }
}
