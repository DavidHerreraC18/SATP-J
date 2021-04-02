import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/providers/provider_preaprobacion_pacientes.dart';

class PreAprobDialog extends StatefulWidget {
  PreAprobDialog({
    Key key,
    this.formularioSeleccionado,
  }) : super(key: key);

  final Formulario formularioSeleccionado;

  @override
  _PreAprobDialogState createState() => _PreAprobDialogState();
}

class _PreAprobDialogState extends State<PreAprobDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 400,
              color: Colors.white,
              child: _contenido(widget.formularioSeleccionado),
            )));
  }

  Column _contenido(Formulario formularioSeleccionado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Nombre Completo',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 2.0,
        ),
        Container(
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              formularioSeleccionado.paciente.nombre +
                  " " +
                  formularioSeleccionado.paciente.apellido,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'Motivo de Consulta',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 2.0,
        ),
        Container(
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              formularioSeleccionado.motivoConsulta,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '¿Fue Atendido Anteriormente?',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 2.0,
        ),
        Container(
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: _booleano(formularioSeleccionado.fueAtendido),
          ),
        ),
        Row(
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
                overlayColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondaryVariant),
                alignment: Alignment.center,
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onPressed: () {
                aprobarPaciente(formularioSeleccionado);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 15.0,
                ),
                child: Text(
                  'PreAprobar Paciente',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.error),
                overlayColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondaryVariant),
                alignment: Alignment.center,
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 15.0,
                ),
                child: Text(
                  'Rechazar Paciente',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Text _booleano(bool respuesta) {
    if (respuesta == true) {
      return Text(
        "SI",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18.0),
      );
    } else {
      return Text(
        "NO",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18.0),
      );
    }
  }

  Future<void> aprobarPaciente(Formulario formulario) async {
    String string =
        await ProviderAdministracionFormularios.preAprobarPaciente(formulario);
    print(string);
  }
}
