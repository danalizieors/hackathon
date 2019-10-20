import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mock/apiService/apiClient.dart';
import 'package:mock/apiService/constans.dart';
import 'package:mock/appState.dart';
import 'package:mock/authService/authService.dart';
import 'package:mock/models/drawerItem.dart';
import 'package:mock/models/sensors.dart';
import 'package:mock/screens/privacyScreen.dart';
import 'package:mock/screens/sensorsScreen.dart';
import 'package:mock/screens/submit_screens/welcomeScren.dart';
import 'package:mock/screens/userScreen.dart';

import 'dialogs.dart';


class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();



  final drawerItems = [
    new DrawerItem('Main screen', Icons.home),
    new DrawerItem('All sensors', Icons.watch),
    new DrawerItem('Account', Icons.account_circle),
    new DrawerItem('Settings', Icons.settings),
    new DrawerItem('Privacy Policy', Icons.filter_none)
  ];


}

class _HomeScreenState extends State<HomeScreen> {


  var drawerOptions =new List<Widget>();
  int _selectedDrawerIntex = 0;



  @override
  void initState() {
    buildDrawerItems();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseUser user;

  void showSnackBar() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text("Hope you are doing fine " + user.displayName),
              duration: Duration(seconds: 3),),
            ));
  }





  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot){
        if(snapshot.hasData){
          user = snapshot.data;
          return WillPopScope(
            onWillPop: () => closeApp(context),
            child: mainScaffold(),
          );
        }
        else{
          return WillPopScope(
            onWillPop: () => closeApp(context),
            child: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      }
    );
  }








  Scaffold mainScaffold() {
    return Scaffold(
        drawer: drawer(),
        key: _scaffoldKey,
        appBar: appBar(title: widget.drawerItems[_selectedDrawerIntex].name),
        floatingActionButton: _selectedDrawerIntex == 0 ? FloatingActionButton(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => PostSickness()), ModalRoute.withName('/')),
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ) : null,
        body: _getDrawerItemWidget(_selectedDrawerIntex)
    );
  }






  //------AppBar-------------//
  /*
    params:
    title - Takes a string as the appBar's content
            default value - HealPal
  */


  AppBar appBar({String title = "HealPal"}){
    return AppBar(
      centerTitle: true,
      title: Text(title),
    );
  }



//------------------------------//









  //------------Drawer----------------------------//
  
  
  //-------------Drawer ui elements-------------------//

  Drawer drawer() {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          getUserAccountDrawerHeader(),
          Column(
              children: drawerOptions
          ),
          logOutButton()
        ],
      ),
    );

  }


  UserAccountsDrawerHeader getUserAccountDrawerHeader() {
    return UserAccountsDrawerHeader(

      accountName: new Text(user.displayName),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: NetworkImage(user.photoUrl),
      ),
    );
  }



  Expanded logOutButton(){
    return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: new ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Log out"),
                onTap: logOutMethod
            )
        )
    );
  }




  //---------Log out method ------------//

  //logs the user out from Firebase and clears the navigation history
  void logOutMethod() async{
                AuthClient.instance.signOut();
                NavigatorState navigator = Navigator.of(context);
                Navigator.of(context).pop();
                Route route = ModalRoute.of(context);
                while(navigator.canPop())
                  navigator.removeRouteBelow(route);
                await navigator.push(
                  MaterialPageRoute(builder: (BuildContext context) => App(),
                  ),
                );
  }



  //Builds the widgets in the drawer
  buildDrawerItems(){

    drawerOptions = new List<Widget>();

    for(var i = 0; i < widget.drawerItems.length - 1; ++i){
      var item = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: Icon(item.icon),
            title: Text(item.name),
            selected: i == _selectedDrawerIntex,
            onTap: () => _onDrawerIndex(i),
          )
      );
    }
    drawerOptions.add(
      new ListTile(
        leading: Icon(widget.drawerItems[4].icon),
        title: Text(widget.drawerItems[4].name),
        onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => PrivacyScreen()), ModalRoute.withName('/'))
         ));
  }



  //changes the current drawer index
  _onDrawerIndex(int index){
    //  buildDrawerItems();
    setState(() {
      _selectedDrawerIntex = index;
      Navigator.of(context).pop();
    });

  }


  //returns a screen associated to a drawer item
  _getDrawerItemWidget(int pos){
    buildDrawerItems();
    switch(pos){
      case 0:
        showSnackBar();
        return WelcomeScreen();
      case 1:
        return SensorsScreen();
      case 2:
        return UserScreen();

    }
  }


//-------------------------------//

}


