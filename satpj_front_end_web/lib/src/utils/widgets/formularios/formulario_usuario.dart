import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';

class FormUserPersonalInformation extends StatefulWidget {
  Usuario usuario = new Usuario();
  String prefix;
  String label;
  bool enabled;
  bool fechaNacimiento;

  FormUserPersonalInformation(
      {this.usuario,
      this.prefix = 'el',
      this.label = 'del practicante',
      this.enabled = true,
      this.fechaNacimiento = false});

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormUserPersonalInformation> {
  TextEditingController textControllerNombres;
  FocusNode textFocusNodeNombres;
  bool _isEditingNombres = false;

  TextEditingController textControllerApellidos;
  FocusNode textFocusNodeApellidos;
  bool _isEditingApellidos = false;

  TextEditingController textControllerTipoDocumento;
  FocusNode textFocusNodeTipoDocumento;

  TextEditingController textControllerDocumento;
  FocusNode textFocusNodeDocumento;
  bool _isEditingDocumento = false;

  TextEditingController textControllerFechaNacimiento;

  TextEditingController textControllerDireccion;
  FocusNode textFocusNodeDireccion;
  bool _isEditingDireccion = false;

  TextEditingController textControllerEmail;
  FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;

  TextEditingController textControllerTelefono;
  FocusNode textFocusNodeTelefono;
  bool _isEditingTelefono = false;

  @override
  void initState() {
    textControllerNombres = TextEditingController(text: widget.usuario.nombre);
    textControllerApellidos =
        TextEditingController(text: widget.usuario.apellido);
    textControllerTipoDocumento =
        TextEditingController(text: widget.usuario.tipoDocumento);
    textControllerDocumento =
        TextEditingController(text: widget.usuario.documento);
    textControllerFechaNacimiento = TextEditingController(text: null);
    textControllerDireccion =
        TextEditingController(text: widget.usuario.direccion);
    textControllerEmail = TextEditingController(text: widget.usuario.email);
    textControllerTelefono =
        TextEditingController(text: widget.usuario.telefono);

    textFocusNodeNombres = FocusNode();
    textFocusNodeApellidos = FocusNode();
    textFocusNodeTipoDocumento = FocusNode();
    textFocusNodeDocumento = FocusNode();
    textFocusNodeDireccion = FocusNode();
    textFocusNodeEmail = FocusNode();
    textFocusNodeTelefono = FocusNode();

    if (widget.enabled) {
      textFocusNodeTipoDocumento.unfocus();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: temaFormularios(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Nombre',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          RoundedTextFieldValidators(
              textFocusNode: textFocusNodeNombres,
              textController: textControllerNombres,
              textInputType: TextInputType.text,
              isEditing: _isEditingNombres,
              enabled: widget.enabled,
              hintText: 'Ingrese ' + widget.prefix + ' nombre ' + widget.label,
              validate: () {
                widget.usuario.nombre = textControllerNombres.text;
                return ValidadoresInput.validateEmpty(
                    textControllerNombres.text,
                    'Debe ingresar ' +
                        widget.prefix +
                        ' nombre ' +
                        widget.label,
                    '');
              }),
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
          RoundedTextFieldValidators(
              textFocusNode: textFocusNodeApellidos,
              textController: textControllerApellidos,
              textInputType: TextInputType.text,
              isEditing: _isEditingApellidos,
              enabled: widget.enabled,
              hintText:
                  'Ingrese ' + widget.prefix + 's apellidos ' + widget.label,
              validate: () {
                widget.usuario.apellido = textControllerApellidos.text;
                return ValidadoresInput.validateEmpty(
                    textControllerApellidos.text,
                    'Debe ingresar ' +
                        widget.prefix +
                        's apellidos ' +
                        widget.label,
                    '');
              }),
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
          Dropdown(
            textController: textControllerTipoDocumento,
            enabled: widget.enabled,
            focusNode: textFocusNodeTipoDocumento,
            hintText: 'Tipo de documento',
            values: kTtipoDocumento,
            validate: () {
              widget.usuario.tipoDocumento = textControllerTipoDocumento.text;
              return ValidadoresInput.validateEmpty(
                  textControllerTipoDocumento.text,
                  'Seleccione ' +
                      widget.prefix +
                      ' tipo de documento ' +
                      widget.label,
                  '');
            },
          ),
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
          RoundedTextFieldValidators(
              textFocusNode: textFocusNodeDocumento,
              textController: textControllerDocumento,
              textInputType: TextInputType.number,
              isEditing: _isEditingDocumento,
              enabled: widget.enabled,
              formatter: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              hintText: 'Ingrese ' +
                  widget.prefix +
                  ' número de documento ' +
                  widget.label,
              validate: () {
                widget.usuario.documento = textControllerDocumento.text;
                return ValidadoresInput.validateEmpty(
                    textControllerDocumento.text,
                    'Debe ingresar ' +
                        widget.prefix +
                        ' número de documento ' +
                        widget.label,
                    '');
              }),
          SizedBox(
            height: 20.0,
          ),
          if (widget.fechaNacimiento)
            DateTimePicker(
              type: DateTimePickerType.date,
              dateMask: 'dd-MM-yyyy',
              controller: textControllerFechaNacimiento,
              firstDate: DateTime(1930),
              lastDate: DateTime.now(),
              icon: Icon(Icons.event),
              dateLabelText: 'Fecha Nacimiento',
              onChanged: (val) => print(
                  val), //esAdulto(fechaNacimiento: textControllerFechaNacimiento.text),
              validator: (val) {
                //esAdulto(fechaNacimiento: textControllerFechaNacimiento.text);
                return ValidadoresInput.validateEmpty(
                    textControllerFechaNacimiento.text,
                    'Debe ingresar ' +
                        widget.prefix +
                        ' fecha de nacimiento ' +
                        widget.label,
                    '');
              },

              onSaved: (val) => print(val),
            ),
          if (widget.fechaNacimiento)
            SizedBox(
              height: 20.0,
            ),
          Text(
            'Correo Electrónico',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          RoundedTextFieldValidators(
              textFocusNode: textFocusNodeEmail,
              textController: textControllerEmail,
              textInputType: TextInputType.emailAddress,
              isEditing: _isEditingEmail,
              enabled: widget.enabled,
              hintText: 'Ingrese ' +
                  widget.prefix +
                  ' correo electrónico ' +
                  widget.label,
              validate: () {
                widget.usuario.email = textControllerEmail.text;
                return ValidadoresInput.validateEmail(
                  textControllerEmail.text,
                );
              }),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Teléfono',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          RoundedTextFieldValidators(
              textFocusNode: textFocusNodeTelefono,
              textController: textControllerTelefono,
              textInputType: TextInputType.phone,
              isEditing: _isEditingTelefono,
              enabled: widget.enabled,
              hintText:
                  'Ingrese ' + widget.prefix + ' teléfono ' + widget.label,
              validate: () {
                widget.usuario.telefono = textControllerTelefono.text;
                return ValidadoresInput.validateEmpty(
                    textControllerTelefono.text,
                    'Debe ingresar ' +
                        widget.prefix +
                        ' número de teléfono ' +
                        widget.label,
                    '');
              }),
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
          RoundedTextFieldValidators(
              textFocusNode: textFocusNodeDireccion,
              textController: textControllerDireccion,
              textInputType: TextInputType.streetAddress,
              isEditing: _isEditingDireccion,
              enabled: widget.enabled,
              hintText:
                  'Ingrese ' + widget.prefix + ' dirección ' + widget.label,
              validate: () {
                widget.usuario.direccion = textControllerDireccion.text;
                return ValidadoresInput.validateEmpty(
                    textControllerDireccion.text,
                    'Debe ingresar ' +
                        widget.prefix +
                        ' dirección ' +
                        widget.label,
                    '');
              }),
          SizedBox(
            height: 20.0,
          ),
        ]),
      ),
    );
  }
}
