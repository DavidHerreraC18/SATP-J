import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:satpj_front_end_web/src/routes/rutas.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      title: 'SATP - J',
      debugShowCheckedModeBanner: false,
      theme: temaSatpj(),
      routes: getAppRoutes(),
      localizationsDelegates: [
        // ... delegado[s] de localización específicos de la app aquí
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale('es'),
      supportedLocales: [
        const Locale('es'), // Español
      ],
    );
  }
}
