import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/documento_paciente/documento_paciente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_web.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';

class FormFormularioExtraInformation extends StatefulWidget {
  final FormularioExtra formularioExtra;
  final bool stack;
  final bool enabled;

  FormFormularioExtraInformation({
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

  bool _isCompleted = false;

  @override
  initState() async {
    await traerDocumentos();
    super.initState();
  }

  traerDocumentos() async {
    List<DocumentoPaciente> documentos =
        await ProviderAdministracionPacientes.traerDocumentosPaciente(
            widget.formularioExtra.paciente);
    if (documentos.isNotEmpty) {
      setState(() {
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  hintText: widget.formularioExtra.tieneEps ? "Si" : "No"),
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
                  hintText: widget.formularioExtra.nombreAcudiente1),
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
                  hintText: widget.formularioExtra.numeroAcudiente1),
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
                  hintText: widget.formularioExtra.nombreAcudiente2),
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
                  hintText: widget.formularioExtra.numeroAcudiente2),
              SizedBox(
                height: 8.0,
              ),
              Divider(
                height: 1,
              ),
              Row(
                children: [
                  Container(
                      height: 40.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                        ),
                        onPressed:
                            this._isCompleted ? descargarDocumento() : null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("Ver Documento",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal)),
                        ),
                      )),
                  Container(
                      height: 40.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                        ),
                        onPressed: this._isCompleted
                            ? descargarConsentimientoP()
                            : null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("Ver Consentimiento Principal",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal)),
                        ),
                      )),
                  Container(
                      height: 40.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                        ),
                        onPressed: this._isCompleted
                            ? descargarConsentimientoTP()
                            : null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("Ver Consentimiento Telepsicología",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal)),
                        ),
                      )),
                  Container(
                      height: 40.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                        ),
                        onPressed: this._isCompleted ? descargarRecibo() : null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("Ver Recibo de Pago",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal)),
                        ),
                      )),
                ],
              )
            ]),
          ),
        ),
      ],
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
