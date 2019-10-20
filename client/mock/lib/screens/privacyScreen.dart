import 'package:flutter/material.dart';

import '../appState.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => App()),
              ModalRoute.withName('/')),
        ),
        title: Text("Privacy policy"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Lorem ipsum "),
      ),
    );
  }
}
