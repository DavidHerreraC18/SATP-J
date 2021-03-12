import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_1.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_2.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_3.dart';

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
            return PreRegisterPage1();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      routes: {
        PreRegisterPage1().route : (context) => PreRegisterPage1(),
        PreRegisterPage2().route : (context) => PreRegisterPage2(), 
        PreRegisterPage3().route : (context) => PreRegisterPage3(), 
      },
    );

  }

}