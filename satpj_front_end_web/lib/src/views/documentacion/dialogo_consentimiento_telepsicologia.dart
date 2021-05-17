import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Archivos/file_picker_demo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Firmas/pad_firmas.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/info_paciente_principal_pdf.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/info_paciente_telepsicologia_pdf.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/pdf_consentimiento_principal.dart';

import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_mobile.dart'
    if (dart.library.html) 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_web.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/pdf_consentimiento_telepsicologia.dart';

final PageController pageCtrlr = new PageController();
int currentContainer = 0;
final int numberOfContainers = 3;

void changeContainer() {
  if (currentContainer + 1 > numberOfContainers - 1) return;

  pageCtrlr.animateToPage(
    currentContainer + 1,
    duration: Duration(milliseconds: 750), curve: Curves.linear,
    // you can change the duration of the animation and curve
  );
}

class DialogoConsentimientoTelepsicologia extends StatefulWidget {
  final Paciente pacienteActual;
  final Function funcionConsentimientoTP;
  DialogoConsentimientoTelepsicologia(
      {this.funcionConsentimientoTP, this.pacienteActual, key})
      : super(key: key);
  @override
  DialogoConsentimientoTelepsicologiaState createState() {
    return DialogoConsentimientoTelepsicologiaState();
  }
}

class DialogoConsentimientoTelepsicologiaState
    extends State<DialogoConsentimientoTelepsicologia> {
  @override
  void dispose() {
    pageCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 100,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryColor,
        child: MaterialButton(
            onPressed: () {
              showGeneralDialog(
                  barrierLabel: 'label',
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 300),
                  context: context,
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                          .animate(anim1),
                      child: child,
                    );
                  },
                  pageBuilder: (context, anim1, anim2) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 500,
                        width: 700,
                        padding:
                            EdgeInsets.only(right: 15, left: 15, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: PageView(
                          controller:
                              pageCtrlr, // assign your page controller to the page view
                          physics:
                              NeverScrollableScrollPhysics(), // disables scrolling
                          children: [
                            PrimeraPaginaConsentimientoTelepsicologia(),
                            SegundaPaginaConsentimientoTelepsicologia(
                                pacienteActual: widget.pacienteActual),
                            TerceraPaginaConsentimientoTelepsicologia(
                              pacienteActual: widget.pacienteActual,
                              funcionConsentimientoTP:
                                  widget.funcionConsentimientoTP,
                            ),
                          ],
                          onPageChanged: (int index) =>
                              setState(() => currentContainer = index),
                        ),
                      ),
                    );
                  });
            },
            child: Text(
              "Subir",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}

class PrimeraPaginaConsentimientoTelepsicologia extends StatefulWidget {
  @override
  PrimeraPaginaConsentimientoTelepsicologiaState createState() {
    return PrimeraPaginaConsentimientoTelepsicologiaState();
  }
}

class PrimeraPaginaConsentimientoTelepsicologiaState
    extends State<PrimeraPaginaConsentimientoTelepsicologia> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          currentContainer = 0;
                          Navigator.pop(context);
                        })
                  ],
                ),
                Text(
                  "Introduccion",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor, fontSize: 25),
                ),
                SizedBox(width: 50),
                Text(
                    "La  Telepsicología,  inscrita  en  el  concepto  general  de  la  Telesalud,  es  la  práctica  de  la psicología a través del uso de la tecnología (TICs), como herramienta de acceso y mediación entre el profesional y el paciente, en cualquiera de las fases de la atención en salud como: la promoción, prevención, diagnóstico, tratamiento, rehabilitación y paliación en el campo de la  salud  mental  a  nivel  individual,  familiar  o  comunitario.     La   autorización  de  la Telepsicología, sea como paciente o representantes legales del menor de edad, consienten la utilización   de   las   tecnologías   (TICs)   de   la   telepsicología,   de   forma   sincrónica (videoconferencia, llamada telefónica,–entre otros-) y asincrónica (correo electrónico,–entre otros-) para el desarrollo de actividades de forma autónoma (pruebas, ejercicios, etc.), como estrategias  de  recolección  de  datos  o  validación,  para  así,  determinar  cuáles  son  las problemáticas específicas que está presentando, del cual se establecerá un plan de tratamiento que  le  permitirá  trabajar  en  estas  problemáticas  y  en  la  medida  de  lo  posible,  llegar  a solucionarlas.    Para  que  este  proceso  de  atención  de  telepsicología  tenga  éxito,  es fundamental una infraestructura y mediación de proveedores de dicho servicio, en tal sentido, el  uso  de herramientas  tecnológicas  (TICs)  en  la  TelePsicología  trae  consigo  beneficios como:    a)  Maximización  del  tiempo  personal,  familiar  y  labor  al  eliminar  tiempo  de desplazamiento  para  acceder  a  la  atención,  b)  Mediación  de  la  tecnología  para  adelantar acciones  de  evaluación  entre  consulta  y  consulta,  c)  mejoramiento  en  el  seguimiento  y monitoreo del cambio de forma constante y con retroalimentación inmediata, d) contribuir en  la  mejora  de  tratamientos  al  poder  articularlos  con  ejercicios  modelados,  estrategiascomplementarias,  etc.,  mejorando  los  resultados  y  la  eficiencia  de  la  intervención,  e) incremento en la eficiencia y reducción de los costos de tratamiento. ",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 15),
                Text(
                    "De  otra  parte,  existen  riesgos  en  las  herramientas  tecnológicas  (TICs)  asociadas  a:  a)  El almacenamiento  y  transmisión  de  la  información  que  podría  verse  alterada  o  limitada  por fallas técnicas ocasionando retrasos en el acceso o entrega de resultados, dependiendo de un tercero  para  su  solución,  b)  en  algún  caso  y  dadas  las  características  personales,  el acompañamiento  psicológico  por  telepsicología,  puede  llegar  a  no  ser  suficiente  para  el paciente y requerir la derivación a un colega para la atención personal, e) en menor medida, la  violación  del  nivel  de  seguridad  a  la  plataforma,  donde  se  aloja  lainformación  por  una persona no autorizada exponiendo la privacidad de la información del paciente.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 15),
                Text(
                    "En  este  sentido,  confirmo  que  se  me  ha  informado:  a)  acerca  de  la  confidencialidad  de  la información y que esta podrá ser revelada solo en caso en que elprofesional identifique que existe  un  comportamiento  potencialmente  dañino  durante  la  evaluación  o  tratamiento,  es decir, que atente contra mi vida o la vida de terceros, según la ley 1090, b) que conoceré y seré retroalimentado de los resultados de las pruebas aplicadas, c) que tengo el derecho de negar o retirar mi consentimiento para el uso de la Telepsicología en cualquier momento del proceso en que esté o de la atención de mi hijo(a) sin perjuicio alguno en el presente, o limitar a  futuro  el  derecho  arecibir  atención,  d)  el  derecho  a  permitir  o  negar  la grabación  de  las sesiones,  siempre  previa  autorización  explícita  de  mi  parte.    Autorización  Al  firmar  este documento, autorizo al psicólogo a iniciar el proceso de intervención desde la Telepsicología,de  acuerdo  con  las  características  antes  mencionadas  y  que  me  fueron  explicadas,  se  me permitió preguntar y ser resueltas las dudas.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: 235,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: kPrimaryColor,
                    child: MaterialButton(
                      onPressed: () {
                        changeContainer();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            "Continuar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class SegundaPaginaConsentimientoTelepsicologia extends StatefulWidget {
  final Paciente pacienteActual;
  SegundaPaginaConsentimientoTelepsicologia({this.pacienteActual});
  @override
  SegundaPaginaConsentimientoTelepsicologiaState createState() {
    return SegundaPaginaConsentimientoTelepsicologiaState();
  }
}

final myController = TextEditingController();

class SegundaPaginaConsentimientoTelepsicologiaState
    extends State<SegundaPaginaConsentimientoTelepsicologia> {
  bool validarInput() {
    if (myController.text.isEmpty || myController.text == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          currentContainer = 0;
                          Navigator.pop(context);
                        })
                  ],
                ),
                Text(
                  "Declaración",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor, fontSize: 25),
                ),
                SizedBox(width: 50),
                Text(
                    "Yo " +
                        widget.pacienteActual.nombre +
                        " " +
                        widget.pacienteActual.apellido +
                        ", identificado con " +
                        widget.pacienteActual.tipoDocumento +
                        ": " +
                        widget.pacienteActual.documento +
                        " expedida en: ",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingrese Lugar de Expedición de su Documento',
                    hintText: '',
                  ),
                  autofocus: false,
                ),
                Text(
                    "Acepto  participar  en  el  proceso  de  atención  desde  la  telepsicologia",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: 235,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: kPrimaryColor,
                    child: MaterialButton(
                      onPressed: () {
                        if (validarInput()) {
                          changeContainer();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Faltan Datos Por Ingresar',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: kAccentColor,
                          ));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            "Confirmar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class TerceraPaginaConsentimientoTelepsicologia extends StatefulWidget {
  final Paciente pacienteActual;
  final Function funcionConsentimientoTP;
  TerceraPaginaConsentimientoTelepsicologia(
      {this.pacienteActual, this.funcionConsentimientoTP});
  @override
  TerceraPaginaConsentimientoTelepsicologiaState createState() {
    return TerceraPaginaConsentimientoTelepsicologiaState();
  }
}

class TerceraPaginaConsentimientoTelepsicologiaState
    extends State<TerceraPaginaConsentimientoTelepsicologia> {
  Uint8List _signatureData;
  bool _isSigned = false;
  bool _opcionFirma = false;
  bool _opcionImagen = false;

  callBack(Uint8List _signatureData, bool _isSigned) {
    this._signatureData = _signatureData;
    setState(() {
      this._isSigned = _isSigned;
      this._opcionImagen = false;
      this._opcionFirma = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          currentContainer = 0;
                          Navigator.pop(context);
                        })
                  ],
                ),
                Text(
                  "Firma",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor, fontSize: 25),
                ),
                SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: _opcionFirma
                                ? Icon(
                                    Icons.check,
                                    color: kAccentColor,
                                  )
                                : SizedBox(height: 25),
                          ),
                          Container(width: 190, child: PadFirmas(callBack)),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 25),
                          Text("O"),
                          Text("Tambien Puede"),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: _opcionImagen
                                ? Icon(
                                    Icons.check,
                                    color: kAccentColor,
                                  )
                                : SizedBox(height: 25),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(),
                            child: Text('Suba una imagen de su firma'),
                            onPressed: () async {
                              var picked = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'png', 'jpeg'],
                              );
                              if (picked != null) {
                                print(picked.files.first.name);
                                _signatureData = picked.files.first.bytes;
                                setState(() {
                                  _isSigned = true;
                                  _opcionImagen = true;
                                  _opcionFirma = false;
                                });
                                //Image thumbnail = copyResize(imagen, width: 120);

                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: 235,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: kPrimaryColor,
                    child: MaterialButton(
                      onPressed: () {
                        currentContainer = 0;
                        if (_isSigned) {
                          completarConsentimientoPrincipal();
                          Navigator.pop(context);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            "Completar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> completarConsentimientoPrincipal() async {
    String nombre =
        widget.pacienteActual.nombre + " " + widget.pacienteActual.apellido;
    String tipoDocumento = widget.pacienteActual.tipoDocumento;
    String documento = widget.pacienteActual.documento;
    String ciudad = myController.text;

    InfoPacienteTelepsicologiaPdf infoP = new InfoPacienteTelepsicologiaPdf(
        nombre: nombre,
        tipoDocumento: tipoDocumento,
        documento: documento,
        ciudad: ciudad,
        signatureData: _signatureData);
    PdfConsentimientoTelepsicologia pdf =
        PdfConsentimientoTelepsicologia(infoP);
    List<int> bytes = await pdf.generatePDF();
    await FileSaveHelper.saveAndLaunchFile(
        bytes, 'Consentimiento Telepsciologia.pdf');
    Uint8List aaa = Uint8List.fromList(bytes);
    widget.funcionConsentimientoTP(aaa);
  }
}
