import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_aprobacion_formularios.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_administrar_pacientes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_perfil/vista_perfil_auxiliar.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_administrar_practicantes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores/vista_administracion_supervisores.dart';
import 'package:satpj_front_end_web/src/views/vista_home.dart';

AppBar toolbarAuxiliarAdministrativo(BuildContext context) {
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
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                // To do
              },
            ),
          ),
          SizedBox(width: 5.0),
          Ink(
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.mail),
              color: Colors.white,
              onPressed: () {
                // To do
              },
            ),
          ),
          SizedBox(width: 5.0),
          Ink(
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.notifications),
              color: Colors.white,
              onPressed: () {
                // To do
              },
            ),
          ),
          SizedBox(width: 5.0),
          Ink(
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
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
                        Icons.assignment, //TOCA CAMBIAR EL ICONO
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Formularios",
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
                  value: 5,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.group,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Supervisores",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 6,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.group,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Practicantes",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 7,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.assignment_turned_in,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Reportes",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 8,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.assignment_rounded,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 2.0),
                      Text("Tareas",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontFamily: 'Dubai'))
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 9,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.verified,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Certificaciones",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 10,
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
                      Navigator.pushNamed(context, VistaPerfilAuxiliar.route);
                    }
                    break;

                  case 3:
                    {
                      Navigator.pushNamed(
                          context, VistaAprobacionFormularios.route);
                    }
                    break;

                  case 4:
                    {
                      Navigator.pushNamed(
                          context, VistaAdministrarPacientes.route);
                    }
                    break;

                  case 5:
                    {
                      Navigator.pushNamed(
                          context, VistaAdministrarSupervisores.route);
                    }
                    break;

                  case 6:
                    {
                      Navigator.pushNamed(
                          context, VistaAdministrarPracticantes.route);
                    }
                    break;

                  case 7:
                    {
                      //statements;
                    }
                    break;

                  case 8:
                    {
                      //statements;
                    }
                    break;

                  case 9:
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
