import 'package:adolescentfinalyearproject/chat/chartDetailsPage.dart';
import 'package:adolescentfinalyearproject/chat/chatModel.dart';
import 'package:adolescentfinalyearproject/container/consultants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:adolescentfinalyearproject/chat/globalConsultants.dart';

import '../globals.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> consultants;
  List<String> consultantKeys;

  @override
  void initState() {
    consultantsRef.once().then((DataSnapshot data) {
      consultants= [];
      consultantKeys= [];
      data.value.forEach((key, value) {
        setState(() {
          consultants.add(value);
          consultantKeys.add(key);
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
      body: consultants == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : consultants.isEmpty
              ? Center(
                  child: Text('No users'),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(consultants[index]['firstName']),
                      onTap: () {
                        final chat = new Chat(key: user['id'] + consultantKeys[index]);
                        chat.getChat().then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatDetailsPage(chat: chat))));
                      },
                    );
                  },
                  itemCount: consultants.length,
                ),
    );
  }
}
