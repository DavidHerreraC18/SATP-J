import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';

/*
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_practicante.dart';
*/
class VistaAdministracionPaciente extends StatefulWidget {
  @override
  createState() => _VistaAdministracionPacienteState();
}

class _VistaAdministracionPacienteState
    extends State<VistaAdministracionPaciente> {
  //final _estiloTexto = Theme.of(context)
  int _conteo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFD4EDEB),
      appBar: toolbarAuxiliarAdministrativo(context),
      body: Center(
          child: PaginatedDataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              "Nombres",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          DataColumn(
            label: Text(
              "Apellidos",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          DataColumn(
            label: Text(
              "Cedula",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          DataColumn(
            label: Text(
              "Telefono",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          DataColumn(
            label: Text(
              "Estado",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          DataColumn(
            label: Text(
              "Acciones",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
        //TODO: agregar data source ,
      )),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _crearBotones(),
    );
  }

  Widget _crearBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 30.0),
        FloatingActionButton(
          child: Icon(Icons.exposure_zero),
          onPressed: _reset,
          heroTag: "btn1",
        ),
        Expanded(child: SizedBox()),
        FloatingActionButton(
          child: Icon(Icons.remove),
          onPressed: _sustraer,
          heroTag: "btn2",
        ),
        SizedBox(
          width: 5.0,
        ),
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _agregar,
          heroTag: "btn3",
        )
      ],
    );
  }

  void _agregar() {
    setState(() => _conteo++);
  }

  void _sustraer() {
    setState(() => _conteo--);
  }

  void _reset() {
    setState(() => _conteo = 0);
  }
}
