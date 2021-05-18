import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

typedef OnRowSelect = void Function(int index);

class FormularioExtraDataTableSource extends DataTableSource {
  FormularioExtraDataTableSource({
    @required List<FormularioExtra> formularios,
    @required this.onRowSelect,
  })  : _formularios = formularios,
        assert(formularios != null);

  final List<FormularioExtra> _formularios;
  final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _formularios.length) {
      return null;
    }
    final _formulario = _formularios[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text('${_formulario.paciente.documento}')),
        DataCell(Text('${_formulario.paciente.tipoDocumento}')),
        DataCell(Text('${_formulario.paciente.nombre}')),
        DataCell(Text('${_formulario.paciente.apellido}')),
        DataCell(Text('${_formulario.paciente.telefono}')),
        DataCell(Text('${_formulario.paciente.email}')),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                //hoverColor: Colors.black,
                splashColor: Colors.blue,
                color: kPrimaryColor,
                icon: const Icon(Icons.assignment),
                onPressed: () => onRowSelect(index),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _formularios.length;

  @override
  int get selectedRowCount => 0;

  /*
   *
   * Sorts this list according to the order specified by the [compare] function.

    The [compare] function must act as a [Comparator].

    List<String> numbers = ['two', 'three', 'four'];
// Sort from shortest to longest.
    numbers.sort((a, b) => a.length.compareTo(b.length));
    print(numbers);  // [two, four, three]
    The default List implementations use [Comparable.compare] if [compare] is omitted.

    List<int> nums = [13, 2, -11];
    nums.sort();
    print(nums);  // [-11, 2, 13] 
   */
  void sort<T>(
      Comparable<T> Function(FormularioExtra f) getField, bool ascending) {
    _formularios.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
