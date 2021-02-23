import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/views/home_page.dart';
import 'package:satpj_front_end_web/src/views/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes(){

  return <String,WidgetBuilder>{
    '/' : (BuildContext context) => HomePage(),
    'login': (BuildContext context) => LoginPage(),
  };
}