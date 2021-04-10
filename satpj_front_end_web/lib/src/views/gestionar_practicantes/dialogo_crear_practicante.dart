import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';

// ignore: must_be_immutable
class DialogoCrearPracticante extends StatefulWidget {
  
  Practicante practicante = new Practicante();

  DialogoCrearPracticante({this.practicante});

  @override
  _DialogoCrearPracticanteState createState() => _DialogoCrearPracticanteState();
}

class _DialogoCrearPracticanteState extends State<DialogoCrearPracticante> {
  
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
          child: Form(
              key: _formKey,
              child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  HeaderDialog(
                    label: 'Crear Practicante',
                    height: 55.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:40.0),
                    child: FormInternInformation(
                      practicante: widget.practicante,
                      ),
                  ),
                  FotterDialog(
                    labelCancelBtn: 'Cancelar',
                    labelConfirmBtn: 'Crear',
                    colorConfirmBtn: kPrimaryColor,
                    paginator: true,
                    width: 120.0,
                  )
                 ],
                ),       
               ]
            ),
          ),
        ),
      ),
    );
  }
}
