import 'package:flutter/material.dart';
import 'package:satpj_front_end_movil/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_movil/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_movil/src/providers/provider_administracion_usuarios.dart';
import 'package:satpj_front_end_movil/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_movil/src/providers/provider_sesiones_terapia.dart';
import 'package:satpj_front_end_movil/src/utils/widgets/barras/drawer_paciente.dart';
import 'package:satpj_front_end_movil/src/utils/widgets/calendarios/CalendarioPrincipal.dart';
import 'package:satpj_front_end_movil/src/utils/widgets/loading/LoadingWanderingCube.dart';

class HomePage extends StatefulWidget {
  static const route = '/home-usuarios';
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Usuario usuario;
  List<SesionUsuario> sesionesUsuario;
  Drawer drawer;
  @override
  initState() {
    super.initState();
  }

  Future<String> obtenerInformacionPrincipal() async {
    String uid = ProviderAuntenticacion.uid;
    print(uid);
    usuario = await ProviderAdministracionUsuarios.buscarUsuario(uid);
    print(uid);
    sesionesUsuario = await ProviderSesionesTerapia.obtenerSesionesUsuario(uid);
    print(uid);
    switch (usuario.tipoUsuario) {
      case "Paciente":
        drawer = drawerPaciente(context, usuario);
        break;
      case "Practicante":
        drawer = drawerPaciente(context, usuario);
        break;
      case "Auxiliar Administrativo":
        drawer = drawerPaciente(context, usuario);
        break;
      case "Acudiente":
        drawer = drawerPaciente(context, usuario);
        break;
      case "Supervisor":
        drawer = drawerPaciente(context, usuario);
        break;
      default:
      // code block
    }
    print(uid);
    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: obtenerInformacionPrincipal(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
                //backgroundColor: Color(0xFFD4EDEB),
                drawer: drawer,
                body: CalendarioPrincipal(
                    sesionesUsuario: sesionesUsuario,
                    usuario:
                        usuario)); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
