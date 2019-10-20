import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mock/authService/authService.dart';


class LoginScreen extends StatefulWidget{

  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>{


  @override
  void initState(){



    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Text("HealPal"),
        centerTitle: true,

      ),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
            image: AssetImage("asset/logo.png"),  
        ),
            
            Center(
              child:
                MaterialButton(
                  onPressed: AuthClient.instance.googleSignIn,
                  color: Color.fromARGB(100, 112, 7, 108),
                  textColor: Colors.black,
                  child: Text("Log in!"),
                )
            ),
          ],
        ),
    );
  }



}


