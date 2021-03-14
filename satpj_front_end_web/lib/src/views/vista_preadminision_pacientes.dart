import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_auxiliar_administrativo.dart';

class VistaPreadmision extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: toolbarAuxiliarAdministrativo(context),
      body: Center(
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(
              label: Text("Nombres", style: Theme.of(context).textTheme.bodyText1,),

            ),
            DataColumn(
              label: Text("Apellidos", style: Theme.of(context).textTheme.bodyText1,),

            ),
            DataColumn(
              label: Text("Cedula", style: Theme.of(context).textTheme.bodyText1,),

            ),
            DataColumn(
              label: Text("Telefono", style: Theme.of(context).textTheme.bodyText1,),

            ),
            DataColumn(
              label: Text("Estado", style: Theme.of(context).textTheme.bodyText1,),

            ),
            DataColumn(
              label: Text("Acciones", style: Theme.of(context).textTheme.bodyText1,),

            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text("juanito Antonio")),
                DataCell(Text("Perez Alonso")),
                DataCell(Text("32776994")),
                DataCell(Text("1234567890")),
                DataCell(Text("Nuevo")),
                //DataCell(BotonAcciones())
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text("Pepita Belen")),
                DataCell(Text("Gutierrez Lopez")),
                DataCell(Text("32776000")),
                DataCell(Text("0987654321")),
                DataCell(Text("PreAprobado")),
                //DataCell(BotonAcciones())
              ]
            ),
            DataRow(
              cells: [
                DataCell(Text("Joseph Miguel")),
                DataCell(Text("Joestar Jimenez")),
                DataCell(Text("8765321")),
                DataCell(Text("09182")),
                DataCell(Text("Nuevo")),
                //DataCell(BotonAcciones()) meter calse botonesTabla.dart aqui 
              ]
            )
          ],
        ),
      ),
    );
  }
}