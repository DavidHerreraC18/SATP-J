import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/button-forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/views/pagos/vista_registro_pago.dart';
import 'package:date_time_picker/date_time_picker.dart';

class PreRegisterPage1 extends StatefulWidget {
  static const route = '/pre-registro-1';

  @override
  _PreRegisterPage1State createState() => _PreRegisterPage1State();
}

class _PreRegisterPage1State extends State<PreRegisterPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAccentColor,
        appBar: toolbarInicio(context),
        body: ListView(
          children: [
            Column(
              children: [
                Card(
                  margin: EdgeInsets.only(
                      right: 100.0, left: 100.0, top: 20.0, bottom: 20.0),
                  elevation: 25.0,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Container(width: 700, child: RegisterForm()),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

final paciente = new Paciente();

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController documento;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: temaFormularios(),
      child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Nombres',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
                child: RoundedTextField(
              hintText: 'Ingrese su nombre',
              validationText: 'Debe ingresar su nombre',
              onChangedF: (value) {
                setState(() {
                  paciente.nombre = value;
                });
              },
            )),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Apellidos',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
                child: RoundedTextField(
              hintText: 'Ingrese sus apellidos',
              validationText: 'Debe ingresar sus apellidos',
              onChangedF: (value) {
                print('hola');
                print(paciente.tipoDocumento);
                setState(() {
                  paciente.apellido = value;
                  print(paciente.tipoDocumento);
                });
              },
            )),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Tipo de documento',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
                height: 50.0,
                child: Dropdown(
                  values: kTtipoDocumento,
                  selected: paciente.documento,
                )),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Número de documento',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedTextField(
              hintText: 'Ingrese su número de documento',
              type: TextInputType.number,
              formatter: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validationText: 'Debe ingresar su número de documento',
              onChangedF: (value) {
                setState(() {
                  paciente.documento = value;
                  print(paciente.tipoDocumento);
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Fecha de Nacimiento',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            DateTimePicker(
              type: DateTimePickerType.date,
              dateMask: 'd MMM, yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              dateLabelText: 'Fecha',
              selectableDayPredicate: (date) {
                // Disable weekend days to select from the calendar
                if (date.weekday == 6 || date.weekday == 7) {
                  return false;
                }

                return true;
              },
              onChanged: (val) => print(val),
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) => print(val),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Dirección',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedTextField(
              hintText: 'Dirección de residencia',
              type: TextInputType.streetAddress,
              validationText: 'Debe ingresar su dirección',
              onChangedF: (value) {
                paciente.direccion = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Estrato sociecómico',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
                height: 50.0,
                child: Dropdown(
                  values: kEstratoSocioeconomico,
                  selected: paciente.estrato,
                  onChanged: (value) {
                    setState(() {
                      paciente.estrato = value;
                    });
                  },
                )),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40.0,
                  child: ButtonForms(
                    formKey: _formKey,
                    label: 'Siguiente',
                    color: kPrimaryColor,
                    route: VistaRegistroPago.route,
                    arguments: paciente,
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
