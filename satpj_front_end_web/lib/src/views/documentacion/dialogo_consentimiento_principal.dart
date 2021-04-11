import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Archivos/file_picker_demo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Firmas/pad_firmas.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/info_paciente_principal_pdf.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Pdf/pdf_consentimiento_principal.dart';

import 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_mobile.dart'
    if (dart.library.html) 'package:satpj_front_end_web/src/utils/widgets/Pdf/helper/save_file_web.dart';

final PageController pageCtrlr = new PageController();
int currentContainer = 0;
bool _success = true;
final int numberOfContainers = 5;
Function funcionConsentimientoP;
Paciente pacienteActual;

void changeContainer(int mov) {
  if (currentContainer + mov > numberOfContainers - 1) return;

  pageCtrlr.animateToPage(
    currentContainer + mov,
    duration: Duration(milliseconds: 750), curve: Curves.linear,
    // you can change the duration of the animation and curve
  );
}

class DialogoConsentimientoPrincipal extends StatefulWidget {
  DialogoConsentimientoPrincipal(Function fP, Paciente pA, {Key key})
      : super(key: key) {
    pacienteActual = pA;
    funcionConsentimientoP = fP;
  }
  @override
  DialogoConsentimientoPrincipalState createState() {
    return DialogoConsentimientoPrincipalState();
  }
}

class DialogoConsentimientoPrincipalState
    extends State<DialogoConsentimientoPrincipal> {
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
                            PrimeraPaginaConsentimientoPrincipal(),
                            SegundaPaginaConsentimientoPrincipal(),
                            TerceraPaginaConsentimientoPrincipal(),
                            CuartaPaginaConsentimientoPrincipal(),
                            QuintaPaginaConsentimientoPrincipal()
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

class PrimeraPaginaConsentimientoPrincipal extends StatefulWidget {
  @override
  PrimeraPaginaConsentimientoPrincipalState createState() {
    return PrimeraPaginaConsentimientoPrincipalState();
  }
}

class PrimeraPaginaConsentimientoPrincipalState
    extends State<PrimeraPaginaConsentimientoPrincipal> {
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
                    "Usted va a iniciar un acompañamiento psicoterapéutico, por parte de un practicante perteneciente a Consultores en Psicología que es una unidad dependiente de la Facultad de Psicología de la Pontificia Universidad Javeriana, a la cual asisten estudiantes con el fin de llevar a cabo la práctica indispensable en su proceso de formación. A continuación, se explican con claridad, profundidad y en un lenguaje comprensible las más importantes características de la intervención sugerida, su indicación, beneficios y potenciales riesgos. Lo invitamos a leer con atención este documento y a discutirlo con su psicólogo tratante, quien gustosamente responderá sus preguntas. En señal de conformidad con la información recibida y con larealización de la intervención planteada, deberá usted firmar el formato correspondiente. Cumplido este requisito procederemos a atenderlo.",
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
                        changeContainer(1);
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

class SegundaPaginaConsentimientoPrincipal extends StatefulWidget {
  @override
  SegundaPaginaConsentimientoPrincipalState createState() {
    return SegundaPaginaConsentimientoPrincipalState();
  }
}

class SegundaPaginaConsentimientoPrincipalState
    extends State<SegundaPaginaConsentimientoPrincipal> {
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
                  "Información General",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor, fontSize: 25),
                ),
                SizedBox(width: 50),
                Text("¿Qué es?",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 20),
                Text(
                    "Un acompañamiento psicoterapéutico es un proceso en el cual el terapeuta y el consultante discuten múltiples experiencias, dificultades y situaciones con el fin de crear un cambio positivo para que el consultante pueda ampliar sus percepciones de la vida y de sí mismo.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 50),
                Text("¿Cómo se hace?",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 20),
                Text(
                    "Usted se reúne una o dos veces a la semana (según el caso), todas las semanas, durante 45 minutos aproximadamente, con el psicólogo tratante. Es importante que asista a las sesiones acordadas y en caso de no poder asistir, solicitamos avisar con 24 horas de anterioridad; además, en caso de fallar a 2 sesiones programadas sin avisar, se cerrará su cupo y se le dará a otra persona; pasados 3 meses usted puede volver a consultar si así lo desea. Al ser un servicio universitario, se programan vacaciones a mitad y al final del año. Las fechas se las comunicará su terapeuta con antelación.Los practicantes de psicología son supervisados por los docentes determinados por la Facultad de Psicología, por lo tanto, su situación personal será discutida con el(los) supervisor(es) del practicante con el fin de que éstos dirijan y vigilen el servicio que se presta.Toda la información concerniente a la evaluación y tratamiento es confidencial y no será divulgada ni entregada a ninguna otra institución o individuo sin su consentimiento expreso, excepto cuando la orden de entrega provenga de una autoridad judicial competente. Este principio de confidencialidad será quebrantado en caso presentarse situaciones que pongan en grave peligro la integridad física o mental de algún miembro de la comunidad. La valoración de la gravedad de la situación, que justifique quebrantar el principio de confidencialidad, será determinada por los supervisores del programa en concepto escrito que será puesto en su conocimiento, pero que no tiene que contar con su aceptación expresa.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 50),
                Text("¿Cuándo se hace?",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 20),
                Text(
                    "Los acuerdos de programación de citas serán establecidos entre usted y el psicólogo.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 50),
                Text("¿Cuáles son los beneficios?",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 20),
                Text(
                    "La terapia brinda la oportunidad de que usted se pueda conocer mejor y con más profundidad y aporta recursos para afrontar las dificultades que pueda estar experimentando.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 50),
                Text("¿Cuáles son las complicaciones?",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 20),
                Text(
                    "El servicio no implica atención en emergencias. Si usted o su acudiente consideran que necesita atención de urgencia, por favor llame al 123 o diríjase al hospital más cercano. En dicho proceso, es necesario el esfuerzo conjunto entre el consultante y el terapeuta. El progreso y el éxito de la terapia dependen del motivo de consulta, y de muchos otros factores que pueden influir en el mismo.",
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
                        changeContainer(1);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            "Entiendo",
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

class TerceraPaginaConsentimientoPrincipal extends StatefulWidget {
  @override
  TerceraPaginaConsentimientoPrincipalState createState() {
    return TerceraPaginaConsentimientoPrincipalState();
  }
}

class TerceraPaginaConsentimientoPrincipalState
    extends State<TerceraPaginaConsentimientoPrincipal> {
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
                  "Autorización",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor, fontSize: 25),
                ),
                SizedBox(width: 50),
                Text(
                    "He comprendido el contenido de este documento y las explicaciones que me han brindado, también se me ha permitido expresar mis observaciones y se me han resuelto las dudas y preguntas que he formulado respecto a los fines, alternativas, métodos, ventajas,inconvenientes y pronóstico del proceso en referencia, así como de los riesgos y complicaciones que por mi situación actual e historia podrían llegar a presentarse. También he sido informado que durante el proceso terapéutico se pueden presentar situaciones imprevistas que pueden hacer cambiar la técnica o plan de manejo inicialmente programado. Se me ha explicado que durante el proceso se podrán grabar imágenes o audios que se conservarán y utilizarán con fines científicos y de docencia en sesiones clínicas, juntas facultativas, conferencias, congresos, publicaciones académicas, investigaciones y actos científicos, evitando cualquier referencia a mi nombre o a datos que permitan establecer mi identidad. Finalmente he sido informado acerca de la naturaleza docente del consultorio, y que por ello participara en mi atención personal en formación, bajo la supervisión de los docentes del servicio y con las limitaciones propias de su nivel de formación.",
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
                        changeContainer(-1);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            "Entiendo",
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

class CuartaPaginaConsentimientoPrincipal extends StatefulWidget {
  @override
  CuartaPaginaConsentimientoPrincipalState createState() {
    return CuartaPaginaConsentimientoPrincipalState();
  }
}

enum Pregunta { Si, No, Unchecked }
List<Pregunta> radioValues = [];
final myController = TextEditingController();

class CuartaPaginaConsentimientoPrincipalState
    extends State<CuartaPaginaConsentimientoPrincipal> {
  void llenarRespuestas() {
    for (int i = 0; i < 10; i++) {
      radioValues.add(Pregunta.Unchecked);
    }
  }

  bool validarInput() {
    if (myController.text.isEmpty || myController.text == null) {
      return false;
    }
    for (int i = 0; i < 10; i++) {
      if (radioValues[i] == Pregunta.Unchecked) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    llenarRespuestas();
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
                        pacienteActual.nombre +
                        " " +
                        pacienteActual.apellido +
                        ", identificado con " +
                        pacienteActual.tipoDocumento +
                        ": " +
                        pacienteActual.documento +
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
                    "He comprendido la naturaleza y propósitos de la intervención a la que libre, consciente y voluntariamente me someto y en consecuencia hago las siguientes declaraciones:",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 50),
                _preguntas(
                    "Que acepto la realización del proceso que me ha sido ampliamente explicado, así como de las intervenciones o modificaciones de conducta que pudieren surgir durante la intervención.",
                    0),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que acepto la toma de grabación en audios o videos durante la intervención, con el propósito y bajo las condiciones informadas.",
                    1),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que entiendo la naturaleza docente del consultorio, que el tratamiento sea atendido por un practicante perteneciente a Consultores en Psicología.",
                    2),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que he sido informado del derecho que tengo a retirarme del proceso si lo estimo conveniente.",
                    3),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que he sido informado de la necesidad de quebrantar el principio de confidencialidad en caso presentarse situaciones que pongan en grave peligro mi integridad física o mental o de algún miembro de la comunidad.",
                    4),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que acepto pueda eventualmente formar parte de investigaciones científicas que aporten al conocimiento e intervención del bienestar psicológico de la comunidad, guardando absoluto rigor en la confidencialidad de los datos personales y de identificación.",
                    5),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que autorizo al practicante para que consulte mi caso con otros profesionales de la Institución o terceros expertos, o ser remitido a consulta con especialista para brindar el mejor tratamiento posiblee.",
                    6),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que entiendo y acepto que el tratamiento al que seré sometido es llevado a cabo atendiendo el mejor esfuerzo del practicante y del grupo de profesionales y que en unos casos funciona mejor que en otros.",
                    7),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que manifiesto que he leído y comprendido íntegramente este documento y en consecuencia acepto su contenido y las consecuencias que de él se deriven.",
                    8),
                Divider(
                  height: 1,
                ),
                _preguntas(
                    "Que he sido informado que en cualquier momento podré revocar la autorización explícita y previa concedida mediante la suscripción del presente documento.",
                    9),
                Divider(
                  height: 1,
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
                        if (validarInput()) {
                          changeContainer(-1);
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

  ListView _preguntas(String pregunta, int numPregu) => ListView(
        shrinkWrap: true,
        children: [
          Container(
              child: Column(
            children: [
              Text(pregunta,
                  textAlign: TextAlign.justify, style: TextStyle(fontSize: 15)),
              Container(
                alignment: Alignment.centerRight,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      Text("Si", style: TextStyle(fontSize: 15)),
                      Radio<Pregunta>(
                        value: Pregunta.Si,
                        groupValue: radioValues[numPregu],
                        activeColor: kPrimaryColor,
                        onChanged: (Pregunta value) {
                          setState(() {
                            radioValues[numPregu] = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("No", style: TextStyle(fontSize: 15)),
                      Radio<Pregunta>(
                        value: Pregunta.No,
                        groupValue: radioValues[numPregu],
                        activeColor: kPrimaryColor,
                        onChanged: (Pregunta value) {
                          setState(() {
                            radioValues[numPregu] = value;
                          });
                        },
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          )),
        ],
      );
}

class QuintaPaginaConsentimientoPrincipal extends StatefulWidget {
  @override
  QuintaPaginaConsentimientoPrincipalState createState() {
    return QuintaPaginaConsentimientoPrincipalState();
  }
}

class QuintaPaginaConsentimientoPrincipalState
    extends State<QuintaPaginaConsentimientoPrincipal> {
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
                                : SizedBox(
                                    height: 25,
                                  ),
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
    List<String> respuestas = [];
    for (int i = 0; i < 10; i++) {
      print(radioValues[i].toString());
      respuestas.add(radioValues[i].toString());
    }
    String nombre = pacienteActual.nombre + " " + pacienteActual.apellido;
    String edad = pacienteActual.edad.toString();
    String tipoDocumento = pacienteActual.tipoDocumento;
    String documento = pacienteActual.documento;
    String ciudad = myController.text;
    String telefono = pacienteActual.telefono;

    InfoPacientePrincipalPdf infoP = new InfoPacientePrincipalPdf(
        nombre: nombre,
        edad: edad,
        tipoDocumento: tipoDocumento,
        documento: documento,
        ciudad: ciudad,
        telefono: telefono,
        respuestas: respuestas,
        signatureData: _signatureData);
    InfoPacientePrincipalPdf infoA = new InfoPacientePrincipalPdf(
        nombre: nombre,
        edad: edad,
        tipoDocumento: tipoDocumento,
        documento: documento,
        ciudad: ciudad,
        telefono: telefono,
        respuestas: respuestas,
        signatureData: _signatureData);
    PdfConsentimientoPrincipal pdf = PdfConsentimientoPrincipal(infoP, infoA);
    List<int> bytes = await pdf.generatePDF();
    await FileSaveHelper.saveAndLaunchFile(
        bytes, 'Consentimiento Informado.pdf');
    Uint8List aaa = Uint8List.fromList(bytes);
    funcionConsentimientoP(aaa);
  }
}
