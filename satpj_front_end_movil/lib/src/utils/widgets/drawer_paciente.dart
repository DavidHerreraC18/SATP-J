import 'package:flutter/material.dart';
import 'package:satpj_front_end_movil/src/utils/autenticacion.dart';

class DrawerPaciente extends StatelessWidget {
  //const DrawerPaciente({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hugo Neutron",
                              style: Theme.of(context).textTheme.subtitle2),
                          Text("Paciente",
                              style: Theme.of(context).textTheme.bodyText2)
                        ],
                      ),
                    )
                  ])),
          Container(
            child: Column(
                children: ListTile.divideTiles(context: context, tiles: [
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Inicio",
                    style: Theme.of(context).textTheme.subtitle1),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.badge,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Perfíl",
                    style: Theme.of(context).textTheme.subtitle1),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.weekend,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Sesiones Terapia",
                    style: Theme.of(context).textTheme.subtitle1),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.payments,
                  color: Color(0xFF2E5EAA),
                ),
                title:
                    Text("Pagos", style: Theme.of(context).textTheme.subtitle1),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Grupos",
                    style: Theme.of(context).textTheme.subtitle1),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
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
}


