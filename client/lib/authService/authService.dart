import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:rxdart/rxdart.dart';







class AuthClient{
  GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> user;

  static final AuthClient _instance = new AuthClient._internal();

  static AuthClient get instance => _instance;



  //constructor
  AuthClient._internal(){
    user = Observable(_firebaseAuth.onAuthStateChanged);
    _googleSignIn = GoogleSignIn();
  }




  //login method
  Future<FirebaseUser> googleSignIn() async{
    GoogleSignInAccount googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
    }catch(e){
      print(e);
    }
    if(googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final authCredential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken);
      FirebaseUser firebaseUser = (await _firebaseAuth
          .signInWithCredential(authCredential)).user;
      return firebaseUser;
    }
    return null;
  }

  Future<FirebaseUser> registerUser(String email, String password) async{
    final AuthResult _authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return _authResult.user;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult _authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return _authResult.user;
  }

  //sign out method
  void signOut() async{
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }





}