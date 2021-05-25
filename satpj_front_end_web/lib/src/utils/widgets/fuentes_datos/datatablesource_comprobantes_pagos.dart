import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/comprobante_pago/comprobante_pago.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

typedef OnRowSelectView = void Function(int index);

class ComprobantesPagosDataTableSource extends DataTableSource {
  ComprobantesPagosDataTableSource({
    @required List<ComprobantePago> comprobantes,
    @required this.onRowSelectView,
  })  : _comprobantes = comprobantes,
        assert(comprobantes != null);

  final List<ComprobantePago> _comprobantes;
  final OnRowSelectView onRowSelectView;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _comprobantes.length) {
      return null;
    }
    final _comprobante = _comprobantes[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text('${_comprobante.fecha.day.toString()}/${_comprobante.fecha.month.toString()}/${_comprobante.fecha.year.toString().toString()}')),
        DataCell(Text('${_comprobante.paqueteSesion.paciente.nombre} ${_comprobante.paqueteSesion.paciente.apellido}')),
        DataCell(Text('${_comprobante.paqueteSesion.paciente.documento}')),
        DataCell(Text('${_comprobante.paqueteSesion.paciente.estrato}')),
        DataCell(Text('${_comprobante.referenciaPago}')),
        DataCell(Text('${_comprobante.paqueteSesion.cantidadSesiones.toString()}')),
        DataCell(Text('${_comprobante.valorTotal}')),
        DataCell(
             Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: kPrimaryColor,
                ),
                color: kPrimaryColor,
                onPressed: () {
                  onRowSelectView(index);
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
  int get rowCount => _comprobantes.length;

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
  void sort<T>(Comparable<T> Function(ComprobantePago c) getField, bool ascending) {
    _comprobantes.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
