import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

typedef OnRowSelectEdit = void Function(int index);
typedef OnRowSelectDelete = void Function(int index);

class SesionesTerapiaDataTableSource extends DataTableSource {
  SesionesTerapiaDataTableSource({
    @required List<SesionTerapia> sesiones,
    @required this.onRowSelectEdit,
    @required this.onRowSelectDelete,
  })  : _sesiones = sesiones,
        assert(sesiones != null);

  final List<SesionTerapia> _sesiones;
  final OnRowSelectEdit onRowSelectEdit;
  final OnRowSelectEdit onRowSelectDelete;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _sesiones.length) {
      return null;
    }
    final _sesion = _sesiones[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text('${_sesion.fecha.toString()}')),
        DataCell(Text('${_sesion.hora.toString()}')),
        DataCell(Text('${_sesion.virtual ? 'Virtual' : 'Presencial'}')),
        DataCell(Text('${_sesion.consultorio}')),
        DataCell(
             Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: kPrimaryColor,
                ),
                color: kPrimaryColor,
                onPressed: () {
                  onRowSelectEdit(index);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_rounded,
                  color: kPrimaryColor,
                ),
                color: kPrimaryColor,
                onPressed: () {
                   onRowSelectDelete(index);
                },
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
  int get rowCount => _sesiones.length;

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
  void sort<T>(Comparable<T> Function(SesionTerapia s) getField, bool ascending) {
    _sesiones.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
