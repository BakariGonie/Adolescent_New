import 'package:adolescentfinalyearproject/chat/chartDetailsPage.dart';
import 'package:adolescentfinalyearproject/chat/chatModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> users;

  @override
  void initState() {
    userRef.once().then((DataSnapshot data) {
      users = [];
      data.value.forEach((key, value) {
        setState(() {
          users.add(value);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select'),
      ),
      body: users == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : users.isEmpty
              ? Center(
                  child: Text('No users'),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(users[index]['firstName']),
                      onTap: () {
                        final chat = new Chat(key: user['id'] + users[index]['id']);
                        chat.getChat().then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatDetailsPage(chat: chat))));
                      },
                    );
                  },
                  itemCount: users.length,
                ),
    );
  }
}
