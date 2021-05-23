import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/providers/provider_administrar_horarios.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/schedule_intern.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_gestionar_horario_practicante.dart';

// ignore: must_be_immutable
class VistaHorarioPracticanteOpcion3 extends StatefulWidget {
  static const route = '/horario-opcion-3';
  String opcion;
  Horario horarioPracticante = new Horario();
  List<Map<String, String>> horario = [];

  VistaHorarioPracticanteOpcion3({this.opcion = '3'});

  @override
  _VistaHorarioPracticanteOpcion3State createState() =>
      _VistaHorarioPracticanteOpcion3State();
}

class _VistaHorarioPracticanteOpcion3State
    extends State<VistaHorarioPracticanteOpcion3> {
  Map<String, List<int>> horarioVista = {};
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      if (arguments['arguments'] is Horario) {
        widget.horarioPracticante = arguments['arguments'] as Horario;
        horarioVista = widget.horarioPracticante.forView();
      }
    }
    else{
       widget.horarioPracticante.opcion = widget.opcion;
    }
    
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
                        child: Text(
                            '                   Horario - Opción ' +
                                widget.opcion,
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
                    onPressed: () async {
                      Navigator.pushNamed(
                          context, VistaGestionarHorarioPracticante.route,
                          arguments: {
                            "arguments": await ProviderAdministracionHorarios
                                .obtenerHorariosPracticante(
                                    ProviderAuntenticacion.uid)
                          });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      widget.horarioPracticante.forReques(horarioVista);
                      if (widget.horarioPracticante.id.isNaN) {
                        ProviderAdministracionHorarios.crearHorarioPracticante(
                            widget.horarioPracticante);
                      } else {
                        ProviderAdministracionHorarios
                            .modificarHorarioPracticante(
                                widget.horarioPracticante);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => DialogDelete(
                                labelHeader: 'Eliminar Opción ' + widget.opcion,
                                label:
                                    '¿Esta seguro que desea eliminar la Opción ' +
                                        widget.opcion +
                                        ' del Horario?  ',
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
              colorSelected: Color(0xff85ADEB),
              horarioVista: horarioVista,
            )
          ],
        ),
      ),
    );
  }
}
