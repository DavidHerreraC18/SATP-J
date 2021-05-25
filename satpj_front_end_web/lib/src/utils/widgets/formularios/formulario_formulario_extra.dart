import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_supervisores.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_web.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';

class FormFormularioExtraInformation extends StatefulWidget {
  final FormularioExtra formularioExtra;
  final Function funcionAsignacionPaciente;
  final bool stack;
  final bool enabled;

  FormFormularioExtraInformation({
    this.funcionAsignacionPaciente,
    this.formularioExtra,
    this.stack = true,
    this.enabled = true,
  });

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormFormularioExtraInformation> {
  Uint8List _consentimientoPrincipal;
  Uint8List _consentimientoTP;
  Uint8List _reciboPago;
  Uint8List _fotoDocumento;

  List<Supervisor> supervisores;
  List<String> supervisoresNombres;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _supervisorNombreActual;
  Supervisor _supervisorActual;

  bool _isCompleted = false;

  @override
  initState() {
    super.initState();
  }

  Future<String> traerDocumentos() async {
    List<DocumentoPaciente> documentos =
        await ProviderAdministracionPacientes.traerDocumentosPaciente(
            widget.formularioExtra.paciente);
    if (documentos.isNotEmpty) {
      for (int i = 0; i < documentos.length; i++) {
        print(documentos[i].tipo);
        if (documentos[i].tipo == "FotoPerfil") {
          _fotoDocumento = Base64Codec().decode(documentos[i].contenido);
        } else if (documentos[i].tipo == "ConsentimientoPrincipal") {
          _consentimientoPrincipal =
              Base64Codec().decode(documentos[i].contenido);
        } else if (documentos[i].tipo == "ReciboPago") {
          _fotoDocumento = Base64Codec().decode(documentos[i].contenido);
        } else if (documentos[i].tipo == "ConsentimientoTP") {
          _consentimientoTP = Base64Codec().decode(documentos[i].contenido);
        }
        _isCompleted = true;
      }
    }
    supervisores = [];
    supervisoresNombres = [];
    supervisores = await ProviderAdministracionSupervisores.traerSupervisores();
    if (supervisores.isNotEmpty) {
      for (int i = 0; i < supervisores.length; i++) {
        supervisoresNombres
            .add(supervisores[i].nombre + " " + supervisores[i].apellido);
      }
      _supervisorNombreActual = supervisoresNombres[0];
      _supervisorActual = supervisores[0];
      widget.funcionAsignacionPaciente(_supervisorActual);
      _dropDownMenuItems = getDropDownMenuItems();
    }
    return Future.value("Data download successfully");
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String supervi in supervisoresNombres) {
      items.add(new DropdownMenuItem(value: supervi, child: new Text(supervi)));
    }
    return items;
  }

  void changedDropDownItem(String selectedSup) {
    setState(() {
      _supervisorNombreActual = selectedSup;
      for (int i = 0; i < supervisoresNombres.length; i++) {
        if (supervisoresNombres[i] == _supervisorNombreActual) {
          _supervisorActual = supervisores[i];
          widget.funcionAsignacionPaciente(_supervisorActual);
          i = supervisoresNombres.length;
        }
      }
    });
    widget.funcionAsignacionPaciente(_supervisorActual);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: traerDocumentos(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Stack(
              children: [
                Container(
                  margin: widget.stack
                      ? EdgeInsets.symmetric(vertical: 35.0, horizontal: 5.0)
                      : null,
                  padding: widget.stack
                      ? EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 30.0, bottom: 20.0)
                      : null,
                  decoration: widget.stack
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: kPrimaryColor, width: 2.0),
                        )
                      : null,
                  child: Theme(
                    data: temaFormularios(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Escolaridad',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText: widget.formularioExtra.escolaridad),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Ocupación',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText: widget.formularioExtra.ocupacion),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Institución donde trabaja o estudia',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText: widget.formularioExtra.lugarOcupacion),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Estado Civil',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText: widget.formularioExtra.estadoCivil),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Servicio de salud',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText: widget.formularioExtra.tieneEps
                                  ? "Si"
                                  : "No"),
                          SizedBox(
                            height: 20.0,
                          ),
                          widget.formularioExtra.tieneEps
                              ? Text(
                                  'EPS',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 18.0),
                                )
                              : SizedBox.shrink(),
                          widget.formularioExtra.tieneEps
                              ? SizedBox(
                                  height: 8.0,
                                )
                              : SizedBox.shrink(),
                          widget.formularioExtra.tieneEps
                              ? RoundedTextFieldDisabled(
                                  type: TextInputType.text,
                                  hintText: widget.formularioExtra.eps)
                              : SizedBox.shrink(),
                          widget.formularioExtra.tieneEps
                              ? SizedBox(
                                  height: 20.0,
                                )
                              : SizedBox.shrink(),
                          widget.formularioExtra.tieneEps
                              ? Text(
                                  'Tipo de Vinculación',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 18.0),
                                )
                              : SizedBox.shrink(),
                          widget.formularioExtra.tieneEps
                              ? SizedBox(
                                  height: 8.0,
                                )
                              : SizedBox.shrink(),
                          widget.formularioExtra.tieneEps
                              ? RoundedTextFieldDisabled(
                                  type: TextInputType.text,
                                  hintText: widget.formularioExtra.estadoEps)
                              : SizedBox.shrink(),
                          Text(
                            '¿Cómo se enteró del servicio de Consultores en Psicología?',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText: widget.formularioExtra.servicio),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Acudiente #1',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Nombre del acudiente',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText:
                                  widget.formularioExtra.nombreAcudiente1),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Número del acudiente',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText:
                                  widget.formularioExtra.numeroAcudiente1),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Acudiente #2',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Nombre del acudiente',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText:
                                  widget.formularioExtra.nombreAcudiente2),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Número del acudiente',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldDisabled(
                              type: TextInputType.text,
                              hintText:
                                  widget.formularioExtra.numeroAcudiente2),
                          SizedBox(
                            height: 8.0,
                          ),
                          Divider(
                            height: 1,
                          ),
                          Text(
                            'Asignele un Supervisor al Practicante',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          DropdownButtonFormField(
                            decoration: inputDecoration(),
                            value: _supervisorNombreActual,
                            items: _dropDownMenuItems,
                            onChanged: changedDropDownItem,
                          ),
                          (_supervisorActual != null)
                              ? Text('Enfoque: ' + _supervisorActual.enfoque,
                                  style: TextStyle(fontSize: 18.0))
                              : SizedBox(
                                  height: 1,
                                ),
                          (_supervisorActual != null)
                              ? Text('Correo: ' + _supervisorActual.email,
                                  style: TextStyle(fontSize: 18.0))
                              : SizedBox(
                                  height: 1,
                                ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Divider(
                            height: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: new InkWell(
                                      child: new Text(
                                        'Ver Documento',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 18.0),
                                      ),
                                      onTap: () {
                                        if (this._isCompleted) {
                                          descargarDocumento();
                                        }
                                      })),
                              Center(
                                  child: new InkWell(
                                      child: new Text(
                                        'Ver Consentimiento Principal',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 18.0),
                                      ),
                                      onTap: () {
                                        if (this._isCompleted) {
                                          descargarConsentimientoP();
                                        }
                                      })),
                              Center(
                                  child: new InkWell(
                                      child: new Text(
                                        'Ver Consentimiento Telepsicología',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 18.0),
                                      ),
                                      onTap: () {
                                        if (this._isCompleted) {
                                          descargarConsentimientoTP();
                                        }
                                      })),
                              Center(
                                  child: new InkWell(
                                      child: new Text(
                                        'Ver Recibo de Pago',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 18.0),
                                      ),
                                      onTap: () {
                                        if (this._isCompleted) {
                                          descargarRecibo();
                                        }
                                      })),
                            ],
                          ),
                        ]),
                  ),
                ),
              ],
            ); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

  descargarDocumento() async {
    List<int> bytes = _fotoDocumento.toList();
    String aux = widget.formularioExtra.paciente.nombre +
        " " +
        widget.formularioExtra.paciente.apellido;
    await FileSaveHelper.saveAndLaunchImage(
        bytes, 'Documento Identidad -' + aux + '.png');
  }

  descargarConsentimientoP() async {
    List<int> bytes = _consentimientoTP.toList();
    String aux = widget.formularioExtra.paciente.nombre +
        " " +
        widget.formularioExtra.paciente.apellido;
    await FileSaveHelper.saveAndLaunchFile(
        bytes, 'Consentimiento Informado -' + aux + '.pdf');
  }

  descargarConsentimientoTP() async {
    List<int> bytes = _consentimientoPrincipal.toList();
    String aux = widget.formularioExtra.paciente.nombre +
        " " +
        widget.formularioExtra.paciente.apellido;
    await FileSaveHelper.saveAndLaunchFile(
        bytes, 'Consentimiento Informado - Telepsicología' + aux + '.pdf');
  }

  descargarRecibo() async {
    List<int> bytes = _reciboPago.toList();
    String aux = widget.formularioExtra.paciente.nombre +
        " " +
        widget.formularioExtra.paciente.apellido;
    await FileSaveHelper.saveAndLaunchImage(
        bytes, 'Recibo Pago -' + aux + '.png');
  }
}
