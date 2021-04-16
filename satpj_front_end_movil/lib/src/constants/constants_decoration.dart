import 'package:flutter/material.dart';

BoxDecoration kContainerDecoration(BuildContext context){
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Theme.of(context).colorScheme.primary,  
      width: 13.0,
      )
    );
}
