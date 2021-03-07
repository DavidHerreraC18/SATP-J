import 'package:flutter/material.dart';

class DrawerAdmin extends StatelessWidget {
  //const DrawerAdmin({Key key}) : super(key: key);

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
                          Text("Papu de Papus",
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
                  Icons.group,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Pacientes",
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
                  Icons.group,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Supervisores",
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
                  Icons.group,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Practicantes",
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
                  Icons.assignment_turned_in,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Reportes",
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
                  Icons.assignment_rounded,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Tareas",
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
                  Icons.verified,
                  color: Color(0xFF2E5EAA),
                ),
                title: Text("Certificaciones",
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              )
            ]).toList()),
          )
        ],
      ),
    );
  }
}

