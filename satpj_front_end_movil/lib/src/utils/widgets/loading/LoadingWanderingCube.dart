import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:satpj_front_end_movil/src/utils/tema.dart';

class LoadingWanderingCube extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: SpinKitWanderingCubes(color: kPrimaryColor, size: 50.0)));
  }
}
