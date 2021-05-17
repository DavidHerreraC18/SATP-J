import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/schedule_intern.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_gestionar_horario_practicante.dart';

class VistaHorarioPracticanteOpcion2 extends StatefulWidget {
  
  static const route = '/horario-opcion-2';
  String opcion;
  Horario horarioPracticante = new Horario();

  VistaHorarioPracticanteOpcion2({this.opcion = '2'});

  @override
  _VistaHorarioPracticanteOpcion2State createState() =>
      _VistaHorarioPracticanteOpcion2State();
}

class _VistaHorarioPracticanteOpcion2State
    extends State<VistaHorarioPracticanteOpcion2> {
  
  int horas;
  Map<String, List<int>> horarioVista;

  @override
  void initState() {
    widget.horarioPracticante.lunes='8;9;13';
    horas = 7;
    horarioVista = {};
    if(widget.horarioPracticante != null){
       horarioVista = widget.horarioPracticante.forView();
    }
    super.initState();
  }

  bool esHora(String dia){
    if(horarioVista[dia] != null &&
       horarioVista[dia].isNotEmpty && horarioVista[dia].indexOf(horas) > -1 ){
       return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: toolbarPracticante(context),
          body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: kPrimaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          color: kPrimaryColor,
                          child: Center(
                            child: Text('                   Horario - Opción ' + widget.opcion,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                )),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.date_range_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, VistaGestionarHorarioPracticante.route);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(context: context, builder: (context) => DialogDelete(
                             labelHeader: 'Eliminar Opción ' + widget.opcion,
                             label: '¿Esta seguro que desea eliminar la Opción ' + widget.opcion + ' del Horario?  ',
                             labelCancelBtn: 'No',
                             labelConfirmBtn: 'Si',
                             colorConfirmBtn: Theme.of(context).errorColor,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
                
                ScheduleIntern(
                 opcion: '2', 
                 horarioPracticante: widget.horarioPracticante,
                 colorSelected: Color(0xffFCF88C),
                )
          ],
        ),
      ),
    );
  }
}
