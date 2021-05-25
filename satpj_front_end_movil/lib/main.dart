import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_movil/src/app.dart';
//import 'package:satpj_front_end_web/src/app.dart';

void main(){
   WidgetsFlutterBinding.ensureInitialized();
   //await Firebase.initializeApp();
   runApp(ConstructorFirebase());
}

class ConstructorFirebase extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("ERROR");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
            child: CircularProgressIndicator(),
        );
      },
    );
  }
}