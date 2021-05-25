import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_usuarios.dart';
import 'package:satpj_front_end_web/src/providers/provider_administrar_horarios.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialog_delete.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/schedule_intern.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_gestionar_horario_practicante.dart';

// ignore: must_be_immutable
class VistaHorarioPracticanteOpcion1 extends StatefulWidget {
  static const route = '/horario-opcion-1';
  String opcion;
  Horario horarioPracticante = new Horario();
  Practicante practicante = new Practicante();

  VistaHorarioPracticanteOpcion1({this.opcion = '1'});

  @override
  _VistaHorarioPracticanteOpcion1State createState() =>
      _VistaHorarioPracticanteOpcion1State();
}

class _VistaHorarioPracticanteOpcion1State
    extends State<VistaHorarioPracticanteOpcion1> {
  Map<String, List<int>> horarioVista = {};
  bool auxiliar = false;
  Usuario usuario = new Usuario();
  AppBar appBar;

  Future<String> obtenerInformacionPrincipal() async {
    String uid = ProviderAuntenticacion.uid;
    usuario = await ProviderAdministracionUsuarios.buscarUsuario(uid);
    switch (usuario.tipoUsuario) {
      case "Practicante":
        appBar = toolbarPracticante(context);
        break;
      case "Auxiliar Administrativo":
        appBar = toolbarAuxiliarAdministrativo(context);
        auxiliar = true;
        break;
      default:
      // code block
    }
    return Future.value("Data download successfully");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      if (arguments['arguments'] is Horario) {
        if (arguments['arguments'] as Horario != null) {
          widget.horarioPracticante = arguments['arguments'] as Horario;
          horarioVista = widget.horarioPracticante.forView();
        } else {
          widget.horarioPracticante = new Horario();
          horarioVista = {};
        }
      }
      if (arguments['practicante'] is Practicante) {
        if (arguments['practicante'] as Practicante != null) {
          widget.practicante = arguments['practicante'] as Practicante;
        }
      }
    }

    widget.horarioPracticante.opcion = widget.opcion;

    return FutureBuilder<String>(
      future: obtenerInformacionPrincipal(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: !auxiliar
                  ? toolbarPracticante(context)
                  : toolbarAuxiliarAdministrativo(context),
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
                                    (!auxiliar
                                            ? '                   Horario - Opción '
                                            : '                 Horario - Opción ') +
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
                              print('HOLLA' +
                                  auxiliar.toString() +
                                  widget.practicante.id);
                              Navigator.pushNamed(context,
                                  VistaGestionarHorarioPracticante.route,
                                  arguments: {
                                    "arguments":
                                        await ProviderAdministracionHorarios
                                            .obtenerHorariosPracticante(
                                      widget.practicante.id,
                                    ),
                                  });
                            },
                          ),
                          if (auxiliar)
                            IconButton(
                              icon: Icon(
                                Icons.check_box,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => DialogDelete(
                                          labelHeader:
                                              'Aprobar Opción ' + widget.opcion,
                                          label:
                                              '¿Esta seguro que desea aprobar la Opción ' +
                                                  widget.opcion +
                                                  ' del Horario?  ',
                                          labelCancelBtn: 'No',
                                          labelConfirmBtn: 'Si',
                                          colorConfirmBtn:
                                              Theme.of(context).errorColor,
                                          functionDelete: () async {
                                            widget.horarioPracticante.opcion =
                                                'seleccionado';
                                            widget.horarioPracticante
                                                .forReques(horarioVista);
                                            if (widget.horarioPracticante.id ==
                                                null) {
                                              ProviderAdministracionHorarios
                                                  .crearHorarioPracticante(
                                                      widget.horarioPracticante,
                                                      ProviderAuntenticacion
                                                          .uid);
                                            } else {
                                              ProviderAdministracionHorarios
                                                  .modificarHorarioPracticante(
                                                      widget
                                                          .horarioPracticante);
                                            }
                                            Navigator.pushNamed(
                                                context,
                                                VistaGestionarHorarioPracticante
                                                    .route,
                                                arguments: {
                                                  "arguments":
                                                      await ProviderAdministracionHorarios
                                                          .obtenerHorariosPracticante(
                                                              widget.practicante
                                                                  .id)
                                                });
                                          },
                                        ));
                              },
                            ),
                          if (!auxiliar)
                            IconButton(
                              icon: Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                widget.horarioPracticante.opcion = '1';
                                widget.horarioPracticante
                                    .forReques(horarioVista);
                                if (widget.horarioPracticante.id == null) {
                                  ProviderAdministracionHorarios
                                      .crearHorarioPracticante(
                                          widget.horarioPracticante,
                                          ProviderAuntenticacion.uid);
                                } else {
                                  ProviderAdministracionHorarios
                                      .modificarHorarioPracticante(
                                          widget.horarioPracticante);
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.grey[300],
                                        content: Text(
                                          'Guardando Horario',
                                          style: TextStyle(color: Colors.black),
                                        )));
                              },
                            ),
                          if (!auxiliar)
                            IconButton(
                              icon: Icon(
                                Icons.delete_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => DialogDelete(
                                        labelHeader:
                                            'Eliminar Opción ' + widget.opcion,
                                        label:
                                            '¿Esta seguro que desea eliminar la Opción ' +
                                                widget.opcion +
                                                ' del Horario?  ',
                                        labelCancelBtn: 'No',
                                        labelConfirmBtn: 'Si',
                                        colorConfirmBtn:
                                            Theme.of(context).errorColor,
                                        functionDelete: () async {
                                          if (widget.horarioPracticante.id !=
                                              null) {
                                            await ProviderAdministracionHorarios
                                                .eliminarHorarioPracticante(
                                                    widget
                                                        .horarioPracticante.id);
                                            Navigator.pushNamed(
                                                context,
                                                VistaGestionarHorarioPracticante
                                                    .route,
                                                arguments: {
                                                  "arguments":
                                                      await ProviderAdministracionHorarios
                                                          .obtenerHorariosPracticante(
                                                              widget.practicante
                                                                  .id)
                                                });
                                          }
                                        }));
                              },
                            ),
                        ],
                      ),
                    ),
                    ScheduleIntern(
                      opcion: '1',
                      horarioPracticante: widget.horarioPracticante,
                      horarioVista: horarioVista,
                      colorSelected: Color(0xFFFF637D),
                    )
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
