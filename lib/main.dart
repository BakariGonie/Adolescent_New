//import 'package:adolescentfinalyearproject/screens/landingPage.dart';
//import 'package:flutter/material.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Adolescent counseling',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.green,
//        // This makes the visual density adapt to the platform that you run
//        // the app on. For desktop platforms, the controls will be smaller and
//        // closer together (more dense) than on mobile platforms.
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: LandingPage(),
//    );
//  }
//}


import 'package:adolescentfinalyearproject/screens/landingPage.dart';
import 'package:flutter/material.dart';
import 'package:adolescentfinalyearproject/signin/LoginScreen/mainlogo.dart';
import 'package:adolescentfinalyearproject/signin/LoginScreen/signin.dart';
import 'package:adolescentfinalyearproject/signin/LoginScreen/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adolescentfinalyearproject/signin/HomeMain/userscreen.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adolescent counseling',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
       '/profile': (context) => UserScreen(),
  }
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isLoading = false;
  bool _isLogin = false;

  _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = (prefs.get('isLogin') ?? false);

    setState(() {
      _isLogin = isLogin;
    });
  }

  // Upadte Loading value from signin class.
  // If the user try to signin. show loading in this view.
  _updateLoadingStatus(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !_isLogin ? _signInWidget() : LandingPage();
  }

  Widget _signInWidget() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(image:
                AssetImage('assets/images/intro_bg.png'),
                    fit: BoxFit.fill)
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  mainLogo(),
                  SignIn(_updateLoadingStatus), // connecting with child view.
                  SignUp(_updateLoadingStatus)
                ],
              ),
            ),
          ),
          Positioned( // Loading view in the center.
            child: isLoading
                ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              color: Colors.white.withOpacity(0.7),
            )
                : Container(),
          ),
        ],
      ),
    );
  }
}

