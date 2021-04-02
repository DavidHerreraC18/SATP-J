import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';

class DialogoEditarPracticante extends StatefulWidget {
  
  Practicante practicante = new Practicante();

  DialogoEditarPracticante({this.practicante});

  @override
  _DialogoEditarPracticanteState createState() => _DialogoEditarPracticanteState();
}

class _DialogoEditarPracticanteState extends State<DialogoEditarPracticante> {
  
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>(); 
  
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: temaFormularios(),  
        child: 
        Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          width: 800.0,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.1)),
                    color: kPrimaryColor,
                  ),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('Editar Practicante',
                         textAlign: TextAlign.left,
                         style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: (){
                          Navigator.pop(context, widget.practicante);
                        },
                  ),
                    ],
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:40.0),
                  child: FormInternInformation(
                    practicante: widget.practicante,
                    ),
                ),
               ],
              ),
               Divider(
                  color: Colors.grey[400],
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 18.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: 
                    [ 
                      Container(
                        width: 120.0,
                        height: 35.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey[600]),
                          ),
                          onPressed: () {
                             Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text('Cancelar',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0,),
                      Container(
                        width: 120.0,
                        height: 35.0,
                        child: ButtonDialog(
                          formKey: _formKey,
                          label: 'Editar',
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                )),
           ]
          ),
        ),
      ),
    );
  }
}