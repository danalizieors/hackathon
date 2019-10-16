import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mock/authService/authService.dart';


class LoginScreen extends StatefulWidget{

  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Hey"),
      ),
      body:
        Center(
          child:
            MaterialButton(
              onPressed: AuthClient.instance.googleSignIn,
              color: Colors.red,
              child: Text("Log in!"),
            )
        ),
    );
  }



}


