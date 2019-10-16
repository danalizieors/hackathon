import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mock/authService/authService.dart';
import 'dart:convert';
//import 'dart:io';




import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget{
  _HomeScreenState createState() => _HomeScreenState();


}



class _HomeScreenState extends State<HomeScreen>{
  var client = http.Client();

  @override
  void initState(){
    super.initState();
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseUser user;


  void showSnackBar() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Hey " + user.displayName)),
    ));
  }





  void testAPI() async {
    try {
      var response = await client.post('http://192.168.1.103:5000/posts',
          headers: {"Content-type" : "application/json"},
          body: jsonEncode({"user_id": user.uid})
      );
      print(response.statusCode.toString());
    } on Exception catch (exception) {
      print(exception);
    } finally{
      //client.close();
    }
  }

  void testGET() async {
    try {
      var response = await client.get(
          'http://192.168.1.103:8123/api/states/sensor.ambient_sensors',
          headers: {
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhMjdkYWM4NTgxYTM0NjJkODI1Mzk3ZGRiNzRmODJiOCIsImlhdCI6MTU3MTIzOTI0MywiZXhwIjoxODg2NTk5MjQzfQ.m0VTX-o2LG3iwPKHshurV-c-wLEcjYzgTNU9Kv0o99Q",
            "Content-type": "applicaton/json",
          });
      String json = response.body;
      print(json);
    } on Exception catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    key: _scaffoldKey,
      appBar: AppBar(
        title: Text("hey"),
      ),
      body:
        StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot){
              if(snapshot.hasData){
                user = snapshot.data;
                showSnackBar();
                testAPI();
                testGET();

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget> [
                      Text("user uid" + user.uid),
                      MaterialButton(
                        onPressed: AuthClient.instance.signOut,
                        color: Colors.red,
                        child: Text("Log out"),
                      )
                    ]
                  ),
                );
              }
              else{
                return new CircularProgressIndicator();
              }
            }
        ),
        floatingActionButton: FloatingActionButton(onPressed: null,
    child: Icon(Icons.add),),
    );
  }


}