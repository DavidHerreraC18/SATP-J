import 'package:firebase_core/firebase_core.dart';
import 'package:satpj_front_end_web/src/routes/rutas.dart';
import 'package:satpj_front_end_web/src/views/contador_page.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

class MyApp extends StatelessWidget{
  

  @override
  Widget build( context ){

    return MaterialApp(
      title: 'SATP - J',
      debugShowCheckedModeBanner: false,
      theme: temaSatpj(),
      routes: getAppRoutes(),
    );

  }

}