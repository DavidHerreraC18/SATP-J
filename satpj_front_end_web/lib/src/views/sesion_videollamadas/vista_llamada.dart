import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/views/sesion_videollamadas/llamada_jitsi.dart';

class VistaVideoLlamada extends StatefulWidget {
  VistaVideoLlamada({Key key}) : super(key: key);

  @override
  _VistaVideoLlamadaState createState() => _VistaVideoLlamadaState();
}

class _VistaVideoLlamadaState extends State<VistaVideoLlamada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarPaciente(context),
      body: Meeting(),
    );
  }
}
