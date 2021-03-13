import 'package:satpj_front_end_web/src/routes/rutas.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_1.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_2.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_3.dart';

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