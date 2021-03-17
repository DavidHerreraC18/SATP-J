import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/modelo/comprobante_pago.dart';
import 'package:satpj_front_end_web/src/modelo/paquete_sesion.dart';
import 'package:satpj_front_end_web/src/provider/provider_paquete_sesion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_paciente.dart';

final registroPago = ComprobantePago();

class VistaRegistroPago extends StatefulWidget {
  
  static const  route = 'registro-pago';
  
  @override
  _VistaRegistroPagoState createState() => _VistaRegistroPagoState();
}

class _VistaRegistroPagoState extends State<VistaRegistroPago> {


  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: kAccentColor,
      appBar: toolbarPaciente(context),
      body:  Column(
             crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Theme(
                    data: temaFormularios(),
                    child: Card(
                    margin: EdgeInsets.only(
                        right: 400.0, left: 400.0, top: 20.0, bottom: 20.0),
                    elevation: 25.0,
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: 
                    Container(
                      width: 700, 
                       child:  FormularioRegistroPago(),
                       ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class FormularioRegistroPago extends StatefulWidget {

  @override
  _FormularioRegistroPagoState createState() => _FormularioRegistroPagoState();
}

class _FormularioRegistroPagoState extends State<FormularioRegistroPago> {
  
  final _formularioKey = GlobalKey<FormState>();
  
  List<String> paquetesSesiones = ProviderPaqueteSesion.getPaqueteSesionPorIdPaciente();
  String selected;
  @override
  Widget build(BuildContext context) {
    print(paquetesSesiones.length);
    var textFormFieldTotal = TextFormField(
                  //initialValue: registroPago.paqueteSesion.total.toString(),
                  enabled: false,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
    );
        
    return Container(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  'Paquete de sesión:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Referencia de pago:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  decoration: getInputDecoration('Referencia de pago'),
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    registroPago.referenciaPago = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Valor total:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                textFormFieldTotal,
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Observaciones:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              maxLines: null,
              decoration: getInputDecoration('Observaciones'),
              keyboardType: TextInputType.number,
              onChanged: (value){
                registroPago.observacion = value;
              },
            ),
        ]
      )
    );
  }
}


