import 'package:flutter/material.dart';
import 'appState.dart';

void main() => runApp(myApp());


class myApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "secret",
      home: App(),


    );
  }
}