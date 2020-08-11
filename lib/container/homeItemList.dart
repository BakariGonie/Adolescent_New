


import 'dart:async';

import 'package:adolescentfinalyearproject/container/articles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeItemList extends StatefulWidget {
  @override
  _HomeItemListState createState() => new _HomeItemListState();
}

class _HomeItemListState extends State<HomeItemList> {

  StreamSubscription _subscriptionTodo;

  String _todoName = "Display the todo name here";

  @override
  void initState() {
    //FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);

    FirebaseTodos.getTodoStream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
        .then((StreamSubscription s) => _subscriptionTodo = s);
    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionTodo != null) {
      _subscriptionTodo.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemTile = new ListTile(
      title: new Text("$_todoName"),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("home"),
      ),
      body: new ListView(
        children: <Widget>[
          itemTile,
        ],
      ),
    );
  }


  _updateTodo(Todo value) {
    var name = value.title;
    setState((){
      _todoName = name;
    });
  }
}





class Todo {
  final String key;
  String article, author, sender, timestamp, title;


  Todo.fromJson(this.key, Map data) {
    article = data['article'];
    author= data['author'];
    sender = data['sender'];
    timestamp = data['timestamp'];
    title = data['title'];
    if (article == null) {
      article= '';
    }
  }
}





class FirebaseTodos {
  /// FirebaseTodos.getTodoStream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
  /// .then((StreamSubscription s) => _subscriptionTodo = s);
  static Future<StreamSubscription<Event>> getTodoStream(String todoKey,
      void onData(Todo todo)) async {
    String articleKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("articles")
        .child(articleKey)
        .onValue
        .listen((Event event) {
      var todo = new Todo.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }

  /// FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);
  static Future<Todo> getTodo(String todoKey) async {
    Completer<Todo> completer = new Completer<Todo>();

    String articleKey = await Preferences.getAccountKey();

    FirebaseDatabase.instance
        .reference()
        .child("articles")
        .child(articleKey)
        .once()
        .then((DataSnapshot snapshot) {
      var todo = new Todo.fromJson(snapshot.key, snapshot.value);
      completer.complete(todo);
    });

    return completer.future;
  }
}






class Preferences {
  static const String ARTICLE_KEY = "articleKey";

  static Future<bool> setAccountKey(String accountKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ARTICLE_KEY, accountKey);
    return prefs.commit();
  }

  static Future<String> getAccountKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String articleKey = prefs.getString(ARTICLE_KEY);

    // workaround - simulate a login setting this
    if (articleKey == null) {
      articleKey = "-KriFiUADpl-X07hnBC-";
    }

    return articleKey;
  }
}