import 'package:adolescentfinalyearproject/globals.dart';
import 'package:adolescentfinalyearproject/screens/landingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:adolescentfinalyearproject/signin/SignUp/signupmain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  SignIn(this.parentAction);
  final ValueChanged<bool> parentAction;

  @override
  State<StatefulWidget> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {

  final _emailTextController = TextEditingController();
  final _emailTextResetController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailTextController.dispose();
    _emailTextResetController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container( //Wrap the bg as a white color with radius.
          margin: const EdgeInsets.fromLTRB(14,4.0,14,4),
          padding: const EdgeInsets.only(top:10,bottom: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[400]),
            borderRadius: BorderRadius.all(
                Radius.circular(25.0)
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding( // Login Title
                padding: const EdgeInsets.only(left:18.0,top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login',
                  style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
                ),
              ),
              Container( //Wrap the column with grey color border.
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(13.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.all(
                      Radius.circular(25.0)
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 360,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.mail),
                            labelText: 'Email',
                            hintText: 'Type your email'
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Email is required';
                          }else {
                            return null;
                          }
                        },
                        controller: _emailTextController,
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      width: 360,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon:Icon(Icons.lock),
                            labelText: 'Password',
                            hintText: 'Type password'
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Password is required';
                          }else {
                            return null;
                          }
                        },
                        controller: _passwordTextController,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: ()=>_resetPageDialog(),
                    textColor: Colors.blue,
                    child: Text('Forgot Password?'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left:14.0,right: 14.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
//                    side: BorderSide(color: Colors.red)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sign in',
                              style: TextStyle(fontSize: 28),
                            ),
                          ],
                        ),
                        textColor: Colors.white,
                        color: Colors.green[700],
                        padding: EdgeInsets.fromLTRB(10,10.0,10,10),
                        onPressed: () {
                          _signInWithMail();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> _signInWithMail() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      widget.parentAction(true);
      final FirebaseUser firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text
      )).user;

      if (firebaseUser != null) {
        _getDataFromFirebaseDB(firebaseUser);
      }else {
        showDialogWithText('Sign in error');
        widget.parentAction(false);
      }
    }catch(e) {
      showDialogWithText(e.message);
      widget.parentAction(false);
    }
  }


  Future<void> _getDataFromFirebaseDB(FirebaseUser firebaseUser) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (firebaseUser != null) {
        // Check is already sign up
        DataSnapshot userData = await userRef.equalTo(firebaseUser.uid, key: 'id').once();
        Map<dynamic, dynamic> data = userData.value;

//        await prefs.setString('id', data['id']);
//        await prefs.setString('email', data['email']);
//        await prefs.setString('password', documents[0]['password']);
//        await prefs.setString('confirmPassword', documents[0]['confirmPassword']);
//        await prefs.setString('name', documents[0]['name']);
//        await prefs.setString('phone number', documents[0]['phone number']);
//        await prefs.setString('gender', documents[0]['gender']);
//        await prefs.setInt('age', documents[0]['age']);
//        await prefs.setString('blood', documents[0]['blood']);
//        await prefs.setString('image0', documents[0]['image0']);
//        await prefs.setString('image1', documents[0]['image1']);
//        await prefs.setString('image2', documents[0]['image2']);
//        await prefs.setString('image3', documents[0]['image3']);
//        await prefs.setInt('birth_year', documents[0]['birth_year']);
//        await prefs.setInt('birth_month', documents[0]['birth_month']);
//        await prefs.setInt('birth_day', documents[0]['birth_day']);
//        await prefs.setString('intro', documents[0]['intro']);
//        await prefs.setString('createdAt', documents[0]['createdAt']);
//        await prefs.setBool('isLogin', true);
        widget.parentAction(false);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LandingPage()),
        );

      } else {
        showDialogWithText('No user id');
        widget.parentAction(false);
        showDialogWithText('You do not have a account. Move to Create Account');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpMain(firebaseUser: null,)),
        );
      }

    }catch(e) {
      showDialogWithText(e.message);
      widget.parentAction(false);

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
  }

  //reset page dialog
  void _resetPageDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Reset Password"),
          content: new TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.mail),
                labelText: 'Email',
                hintText: 'Type your email'
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Email is required';
              }else {
                return null;
              }
            },
            controller: _emailTextResetController,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Submit"),
              onPressed: () async{
try {
  await _auth.sendPasswordResetEmail(email:_emailTextResetController.text.trim());
}
catch (e){
  print(e);
}
Navigator.of(context).pop();
                },
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}