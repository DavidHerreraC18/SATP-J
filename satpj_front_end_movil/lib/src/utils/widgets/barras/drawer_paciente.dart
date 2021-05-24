import 'package:flutter/material.dart';
import 'package:satpj_front_end_movil/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_movil/src/utils/autenticacion.dart';

Widget drawerPaciente(BuildContext context, Usuario usuario) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/src/utils/images/Perfil.PNG'),
                      radius: 55,
                    ),
                    padding: EdgeInsets.only(right: 20),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(usuario.nombre + " " + usuario.apellido,
                              style: Theme.of(context).textTheme.subtitle2),
                          Text(usuario.tipoUsuario,
                              style: Theme.of(context).textTheme.bodyText2)
                        ],
                      ),
                    ),
                  )
                ])),
        Container(
          child: Column(
              children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color(0xFF2E5EAA),
              ),
              title: Text("Cerrar Sesión",
                  style: Theme.of(context).textTheme.subtitle1),
              onTap: () {
                signOut();
                //Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            )
          ]).toList()),
        )
      ],
    ),
  );
}
