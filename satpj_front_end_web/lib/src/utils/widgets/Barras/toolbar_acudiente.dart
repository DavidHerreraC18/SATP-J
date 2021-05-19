import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_visualizar_pacientes_grupo.dart';
import 'package:satpj_front_end_web/src/views/gestionar_perfil/vista_perfil_acudiente.dart';
import 'package:satpj_front_end_web/src/views/vista_home.dart';

AppBar toolbarAcudiente(BuildContext context) {
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
                        Icons.payments,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Pagos",
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
                      Navigator.pushNamed(context, VistaPerfilAcudiente.route);
                    }
                    break;

                  case 3:
                    {}
                    break;

                  case 4:
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
