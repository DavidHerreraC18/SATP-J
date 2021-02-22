import 'package:firebase_core/firebase_core.dart';
import 'package:satpj_front_end_web/src/views/contador_page.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

class MyApp extends StatelessWidget{
  
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build( context ){

    return MaterialApp(
      title: 'SATP - J',
      debugShowCheckedModeBanner: false,
      theme: temaSatpj(),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Text("ERROR !!!!");
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            //print("ENTRO");
            return ContadorPage();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );

  }

}