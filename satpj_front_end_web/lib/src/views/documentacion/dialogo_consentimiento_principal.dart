import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';


final PageController pageCtrlr = new PageController();
int currentContainer = 0;
bool _success = true;
final int numberOfContainers = 4;

void changeContainer() {
  if (currentContainer + 1 > numberOfContainers - 1) return;

  pageCtrlr.animateToPage(
    currentContainer + 1,
    duration: Duration(milliseconds: 750), curve: Curves.linear,
    // you can change the duration of the animation and curve
  );
}

class DialogoConsentimientoPrincipal extends StatefulWidget {
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
    return ElevatedButton(
        child: Text("Subir"),
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
                    padding: EdgeInsets.only(right: 15, left: 15, bottom: 20),
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
                        CuartaPaginaConsentimientoPrincipal()
                      ],
                      onPageChanged: (int index) =>
                          setState(() => currentContainer = index),
                    ),
                  ),
                );
              });
        });
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
                Container(
                  color: kPrimaryColor,
                  height: 50.0,
                  width: 650.0,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
            Text(
              "Introduccion",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF2E5EAA), fontSize: 25),
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
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF2E5EAA),
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
                      color: Color(0xFF2E5EAA),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            Text(
              "Información General",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF2E5EAA), fontSize: 25),
            ),
            SizedBox(width: 50),
            Text("¿Qué es?",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 20),
            Text(
                "Un acompañamiento psicoterapéutico es un proceso en el cual el terapeuta y el consultante discuten múltiples experiencias, dificultades y situaciones con el fin de crear un cambio positivo para que el consultante pueda ampliar sus percepciones de la vida y de sí mismo.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 50),
            Text("¿Cómo se hace?",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 20),
            Text(
                "Usted se reúne una o dos veces a la semana (según el caso), todas las semanas, durante 45 minutos aproximadamente, con el psicólogo tratante. Es importante que asista a las sesiones acordadas y en caso de no poder asistir, solicitamos avisar con 24 horas de anterioridad; además, en caso de fallar a 2 sesiones programadas sin avisar, se cerrará su cupo y se le dará a otra persona; pasados 3 meses usted puede volver a consultar si así lo desea. Al ser un servicio universitario, se programan vacaciones a mitad y al final del año. Las fechas se las comunicará su terapeuta con antelación.Los practicantes de psicología son supervisados por los docentes determinados por la Facultad de Psicología, por lo tanto, su situación personal será discutida con el(los) supervisor(es) del practicante con el fin de que éstos dirijan y vigilen el servicio que se presta.Toda la información concerniente a la evaluación y tratamiento es confidencial y no será divulgada ni entregada a ninguna otra institución o individuo sin su consentimiento expreso, excepto cuando la orden de entrega provenga de una autoridad judicial competente. Este principio de confidencialidad será quebrantado en caso presentarse situaciones que pongan en grave peligro la integridad física o mental de algún miembro de la comunidad. La valoración de la gravedad de la situación, que justifique quebrantar el principio de confidencialidad, será determinada por los supervisores del programa en concepto escrito que será puesto en su conocimiento, pero que no tiene que contar con su aceptación expresa.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 50),
            Text("¿Cuándo se hace?",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 20),
            Text(
                "Los acuerdos de programación de citas serán establecidos entre usted y el psicólogo.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 50),
            Text("¿Cuáles son los beneficios?",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 20),
            Text(
                "La terapia brinda la oportunidad de que usted se pueda conocer mejor y con más profundidad y aporta recursos para afrontar las dificultades que pueda estar experimentando.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 50),
            Text("¿Cuáles son las complicaciones?",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF2E5EAA),
                child: MaterialButton(
                  onPressed: () {
                    changeContainer();
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
                      color: Color(0xFF2E5EAA),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            Text(
              "Autorización",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF2E5EAA), fontSize: 25),
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
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF2E5EAA),
                child: MaterialButton(
                  onPressed: () {
                    changeContainer();
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

enum Pregunta1 { Si, No }
enum Pregunta2 { Si, No }
enum Pregunta3 { Si, No }
enum Pregunta4 { Si, No }
enum Pregunta5 { Si, No }
enum Pregunta6 { Si, No }
enum Pregunta7 { Si, No }
enum Pregunta8 { Si, No }
enum Pregunta9 { Si, No }
enum Pregunta10 { Si, No }

class CuartaPaginaConsentimientoPrincipalState
    extends State<CuartaPaginaConsentimientoPrincipal> {
  Pregunta1 resp_preg1;
  @override
  Widget build(BuildContext context) {
    return Material(
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
                      color: Color(0xFF2E5EAA),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            Text(
              "Declaración",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF2E5EAA), fontSize: 25),
            ),
            SizedBox(width: 50),
            Text(
                "Yo David Alejandro Ricaraude Buitrago, mayor de edad, identificado con la Cédula de Ciudadanía No. 1015479406 expedida en: ",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            TextField(
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
            Container(
                child: Column(
              children: [
                Text(
                    "He comprendido la naturaleza y propósitos de la intervención a la que libre, consciente y voluntariamente me someto y en consecuencia hago las siguientes declaraciones:",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15)),
                Container(
                  child: Row(
                    children: [
                      Text("Si",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15)),
                      Radio<Pregunta1>(
                        value: Pregunta1.Si,
                        groupValue: resp_preg1,
                        onChanged: (Pregunta1 value) {
                          setState(() {
                            resp_preg1 = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text("No",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15)),
                      Radio<Pregunta1>(
                        value: Pregunta1.No,
                        groupValue: resp_preg1,
                        onChanged: (Pregunta1 value) {
                          setState(() {
                            resp_preg1 = value;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            )),
            Container(
              height: 50,
              width: 235,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF2E5EAA),
                child: MaterialButton(
                  onPressed: () {
                    changeContainer();
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
