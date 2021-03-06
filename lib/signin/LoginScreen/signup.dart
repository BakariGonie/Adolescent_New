import 'package:adolescentfinalyearproject/screens/landingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:adolescentfinalyearproject/signin/SignUp/signupmain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals.dart';

class SignUp extends StatefulWidget {
  SignUp(this.parentAction);
  final ValueChanged<bool> parentAction;
  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14,4.0,14,14),
      padding: const EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(
            Radius.circular(25.0)
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Row(
                children: <Widget>[
                  Expanded(child: Divider(thickness: 2)),
                  Text(" Sign Up ",
                    style: TextStyle(fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),),
                  Expanded( child: Divider(thickness: 2,)),
                ]
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: new RawMaterialButton(
                  onPressed: () { //Move to SingUp View.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpMain(firebaseUser: null,)),
                    );
                  },
                  child: new Icon(
                    Icons.mail,
                    color: Colors.white,
                    size: 50.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
                margin: EdgeInsets.only(left: 10,right: 10, bottom: 14),
              ),
              Container(
                child: new RawMaterialButton(
                  onPressed: () {
                    signUpWithFacebook();
                  },
                  child: Text('f',
                    style: TextStyle(color: Colors.white,
                        fontSize: 56,fontWeight: FontWeight.bold),),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.blue[900],
                  padding: const EdgeInsets.all(8.0),
                ),
                margin: EdgeInsets.only(left: 10,right: 10, bottom: 14),
              ),
              Container(
                child: new RawMaterialButton(
                  onPressed: () {
                    _googleSignUp();
                  },
                  child: Image.asset('assets/images/google_logo.png',
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(22.0),
                ),
                margin: EdgeInsets.only(left: 10,right: 10, bottom: 14),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> signUpWithFacebook() async{
    try {
      widget.parentAction(true);

      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if(result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        _checkExistUserFromFirebaseDB(user);
        return user;
      }else {
        showDialogWithText('Facebook Sign in fail');
        widget.parentAction(false);
      }
    }catch (e) {
      showDialogWithText(e.message);
    }
  }

  Future<void> _googleSignUp() async {
    try {
      widget.parentAction(true);

      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      _checkExistUserFromFirebaseDB(user);
      return user;
    }catch (e) {
      showDialogWithText(e.message);
    }
  }

  Future<void> _checkExistUserFromFirebaseDB(FirebaseUser firebaseUser) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result =
        await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        if (documents.length == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpMain(firebaseUser: firebaseUser,)),
          );
        } else {
          // Write data to local
          DataSnapshot userData = await userRef.equalTo(firebaseUser.uid, key: 'id').once();
          Map<dynamic, dynamic> data = userData.value;
          await prefs.setString('id', data['id']);
          await prefs.setString('email', data['email']);
          await prefs.setString('firstname', data['firstname']);
          await prefs.setString('lastname', data['lastname']);
          await prefs.setString('phone number', data['phone number']);
          await prefs.setString('gender', data['gender']);
          await prefs.setInt('age', data['age']);
          await prefs.setString('blood', data['blood']);
          await prefs.setString('image0', data['image0']);
          await prefs.setString('image1', data['image1']);
          await prefs.setString('image2', data['image2']);
          await prefs.setString('image3', data['image3']);
          await prefs.setInt('birth_year', data['birth_year']);
          await prefs.setInt('birth_month', data['birth_month']);
          await prefs.setInt('birth_day', data['birth_day']);
          await prefs.setString('intro', data['intro']);
          await prefs.setString('createdAt', data['createdAt']);
          await prefs.setBool('isLogin', true);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LandingPage()),
          );
        }
        widget.parentAction(false);
      } else {
        showDialogWithText('No user id');
        widget.parentAction(false);
      }
    }catch(e) {
      showDialogWithText(e.message);
    }
  }

  showDialogWithText(String textMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(textMessage),
          );
        }
    );
    widget.parentAction(false);
  }
}