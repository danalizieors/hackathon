import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class UserScreen extends StatefulWidget{

  _UserScreenState createState() => _UserScreenState();

}


class _UserScreenState extends State<UserScreen>{

  Position _position;
  FirebaseUser _user;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          _user = snapshot.data;
          return Center(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar( backgroundImage:
                      NetworkImage(_user.photoUrl),
                    radius: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_user.displayName, style: TextStyle(fontSize: 24),),
                  ),
                ],
              ),
            ),

        ]
            ),
          );
      } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
    
  }











  Future<Position> getLocation() async{

    try {
      _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
    on Exception catch(e){
      print(e);

    }
    print(_position);
  }
}