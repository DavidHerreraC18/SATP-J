import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_visualizar_pacientes_supervisor.dart';
import 'package:satpj_front_end_web/src/views/gestionar_perfil/vista_perfil_supervisor.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_visualizar_practicantes.dart';
import 'package:satpj_front_end_web/src/views/vista_home.dart';

AppBar toolbarSupervisor(BuildContext context) {
  return AppBar(
    leading: Image.asset(
      'lib/src/utils/images/logo_plataforma.png',
      fit: BoxFit.cover,
      height: 35.0,
    ),
    title: Text("SATP-J", style: TextStyle(color: Color(0xFF2E5EAA))),
    actions: [
      ButtonBar(
        children: <Widget>[
          Ink(
            decoration: const ShapeDecoration(
              color: Color(0xFF2E5EAA),
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, HomePage.route);
              },
            ),
          ),
          SizedBox(width: 5.0),
          Ink(
            decoration: const ShapeDecoration(
              color: Color(0xFF2E5EAA),
              shape: CircleBorder(),
            ),
            child: PopupMenuButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Inicio",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.badge,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Perfíl",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.group, //TOCA CAMBIAR EL ICONO
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Pacientes",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 4,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.group,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Mis Practicantes",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 5,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.assignment_rounded, //QUEJESA JOA
                        color: Colors.grey,
                      ),
                      SizedBox(width: 2.0),
                      Text("Mis Tareas",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontFamily: 'Dubai'))
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 6,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.logout,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Cerrar Sesión",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 1:
                    {
                      Navigator.pushNamed(context, HomePage.route);
                    }
                    break;

                  case 2:
                    {
                      Navigator.pushNamed(context, VistaPerfilSupervisor.route);
                    }
                    break;

                  case 3:
                    {
                      Navigator.pushNamed(
                          context, VistaVisualizarPacientesSupervisor.route);
                    }
                    break;

                  case 4:
                    {
                      Navigator.pushNamed(
                          context, VistaVisualizarPracticantes.route);
                    }
                    break;

                  case 5:
                    {}
                    break;

                  case 6:
                    {
                      ProviderAuntenticacion.signOut();
                      Navigator.pushNamed(context, "/");
                    }
                    break;
                }
              },
            ),
          ),
          SizedBox(width: 5.0),
        ],
      ),
    ],
  );
}
