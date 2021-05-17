import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante_paciente.dart';

typedef OnRowSelectDetail = void Function(int index);
typedef OnRowSelectEdit = void Function(int index);
typedef OnRowSelectDelete = void Function(int index);

class PacientesPracticantesDataTableSource extends DataTableSource {
  PacientesPracticantesDataTableSource(
      {@required List<PracticantePaciente> practicantepacientes,
      @required this.onRowSelectDetail,
      @required this.onRowSelectDelete})
      : _practicantepacientes = practicantepacientes,
        assert(practicantepacientes != null);

  final List<PracticantePaciente> _practicantepacientes;
  final OnRowSelectDetail onRowSelectDetail;
  final OnRowSelectDelete onRowSelectDelete;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _practicantepacientes.length) {
      return null;
    }

    final _practicantepaciente = _practicantepacientes[index];
    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text('${_practicantepaciente.paciente.nombre}')),
        DataCell(Text('${_practicantepaciente.paciente.apellido}')),
        DataCell(Text('${_practicantepaciente.paciente.documento}')),
        DataCell(Text('${_practicantepaciente.paciente.email}')),
        DataCell(Text('${_practicantepaciente.paciente.telefono}')),
        DataCell(Text('${_practicantepaciente.paciente.edad}')),
        DataCell(
          ButtonBar(
            children: <Widget>[
              IconButton(
                color: Color(0xFF2E5EAA),
                icon: const Icon(Icons.delete),
                onPressed: () => onRowSelectDelete(index),
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
  int get rowCount => _practicantepacientes.length;

  @override
  int get selectedRowCount => 0;

  /*
   *
   * Sorts this list according to the order specified by the [compare] function.

    The [compare] function must act as a [Comparator].

    List<String> numbers = ['two', 'three', 'four'];
    Sort from shortest to longest.
    numbers.sort((a, b) => a.length.compareTo(b.length));
    print(numbers);  // [two, four, three]
    The default List implementations use [Comparable.compare] if [compare] is omitted.

    List<int> nums = [13, 2, -11];
    nums.sort();
    print(nums);  // [-11, 2, 13] 
   */
  void sort<T>(
      Comparable<T> Function(PracticantePaciente p) getField, bool ascending) {
    _practicantepacientes.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
