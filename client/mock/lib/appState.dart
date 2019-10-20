import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            FirebaseUser user = snapshot.data;
            if (user == null) {
              return LoginScreen();
            } else {
              return HomeScreen();
            }
          } else {
            return new Scaffold(
                body: Center(child: new CircularProgressIndicator()));
          }
        });
  }
}
