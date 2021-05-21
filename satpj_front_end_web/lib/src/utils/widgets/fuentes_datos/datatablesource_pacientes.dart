import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';

typedef OnRowSelectDetail = Widget Function(int index);
typedef OnRowSelectEdit = Widget Function(int index);
typedef OnRowSelectDelete = void Function(int index);
typedef OnRowSelectDate = void Function(int index);

class PacientesDataTableSource extends DataTableSource {
  PacientesDataTableSource(
      {@required List<Paciente> pacientes,
      @required this.onRowSelectDetail,
      @required this.onRowSelectEdit,
      @required this.onRowSelectDelete,
      @required this.onRowSelectDate})
      : _pacientes = pacientes,
        assert(pacientes != null);

  final List<Paciente> _pacientes;
  final OnRowSelectDetail onRowSelectDetail;
  final OnRowSelectEdit onRowSelectEdit;
  final OnRowSelectDelete onRowSelectDelete;
  final OnRowSelectDate onRowSelectDate;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _pacientes.length) {
      return null;
    }
    final _paciente = _pacientes[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text('${_paciente.nombre}')),
        DataCell(Text('${_paciente.apellido}')),
        DataCell(Text('${_paciente.documento}')),
        DataCell(Text('${_paciente.email}')),
        DataCell(Text('${_paciente.telefono}')),
        DataCell(Text('${_paciente.edad}')),
        DataCell(
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                color: Color(0xFF2E5EAA),
                icon: const Icon(Icons.insert_invitation),
                onPressed: () => onRowSelectDate(index),
              ),
              onRowSelectDetail(index),
              onRowSelectEdit(index),
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
  int get rowCount => _pacientes.length;

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
  void sort<T>(Comparable<T> Function(Paciente p) getField, bool ascending) {
    _pacientes.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
