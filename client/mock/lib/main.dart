import 'package:flutter/material.dart';
import 'appState.dart';

void main() => runApp(myApp());


class myApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "HealPal",
     theme: ThemeData(
        primaryColor: Color.fromARGB(255, 171, 203, 137),
        scaffoldBackgroundColor: Colors.white
      ),
      home: App(),


    );
  }
}