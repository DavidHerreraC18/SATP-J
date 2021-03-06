import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';

typedef OnRowSelectDetail = void Function(int index);

class PracticantesVisualizarDataTableSource extends DataTableSource {
  PracticantesVisualizarDataTableSource({
    @required List<Practicante> practicantes,
    @required this.onRowSelectDetail,
  })  : _practicantes = practicantes,
        assert(practicantes != null);

  final List<Practicante> _practicantes;
  final OnRowSelectDetail onRowSelectDetail;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _practicantes.length) {
      return null;
    }
    final _practicante = _practicantes[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text('${_practicante.nombre}')),
        DataCell(Text('${_practicante.apellido}')),
        DataCell(Text('${_practicante.documento}')),
        DataCell(Text('${_practicante.email}')),
        DataCell(Text('${_practicante.telefono}')),
        DataCell(Text('${_practicante.enfoque}')),
        DataCell(
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                color: Color(0xFF2E5EAA),
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () => onRowSelectDetail(index),
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
  int get rowCount => _practicantes.length;

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
  void sort<T>(Comparable<T> Function(Practicante p) getField, bool ascending) {
    _practicantes.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
