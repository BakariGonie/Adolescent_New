import 'package:adolescentfinalyearproject/screens/about_app.dart';
import 'package:adolescentfinalyearproject/screens/available_counselor.dart';
import 'package:adolescentfinalyearproject/screens/contacts.dart';
import 'package:adolescentfinalyearproject/screens/homePage.dart';
import 'package:adolescentfinalyearproject/screens/landingPage.dart';
import 'package:adolescentfinalyearproject/screens/specialPlaces.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:adolescentfinalyearproject/signin/LoginScreen/mainlogo.dart';
import 'package:adolescentfinalyearproject/signin/LoginScreen/signin.dart';
import 'package:adolescentfinalyearproject/signin/LoginScreen/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adolescentfinalyearproject/signin/HomeMain/userscreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'globals.dart';

Future<FirebaseApp> initialize() async {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
//      _showItemDialog(message);
    },
    onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
//      _navigateToItemDetail(message);
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
//      _navigateToItemDetail(message);
    },
  );

  return await FirebaseApp.configure(
      name: 'fyp-web-app',
      options: FirebaseOptions(
        googleAppID: '1:355486033955:android:e18f75dff91ab5845b2996',
        apiKey: 'AIzaSyDAP1FxWErwnbGCjwTQomELNY-my_e7Csk',
        databaseURL: 'https://fyp-web-app.firebaseio.com',
      ));
}

Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }

  // Or do other work.
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  app = await initialize();
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
          '/home': (context) => HomePage(),
          '/available': (context) => AvailableCounselors(),
          '/contacts': (context) => Contacts(),
          '/about': (context) => AboutScreen(),
          '/special': (context) => SpecialPlaces(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
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
    return _isLogin ? LandingPage() : _signInWidget();
  }

  Widget _signInWidget() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/picha.jpg'),
                    fit: BoxFit.fill)),
            child: Center(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  mainLogo(),
                  SignIn(_updateLoadingStatus), // connecting with child view.
                  SignUp(_updateLoadingStatus)
                ],
              ),
            ),
          ),
          Positioned(
            // Loading view in the center.
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
