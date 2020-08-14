import 'package:adolescentfinalyearproject/chat/chatModel.dart';
import 'package:adolescentfinalyearproject/chat/chatUserList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class ChatLanding extends StatefulWidget {
  @override
  _ChatLandingState createState() => _ChatLandingState();
}

class _ChatLandingState extends State<ChatLanding> {
  List<Chat> chats;

  Future<void> loadChat(Chat chat) async {
    await chat.getChat();
    setState(() {
      chats.add(chat);
    });
  }

  Future<void> getChatUsers() async {
    chats = [];
    DatabaseReference messageRef = database.reference().child('messages');
    DataSnapshot snapshot = await messageRef.once();

    List<Future<dynamic>> futures = [];
    snapshot.value.forEach((key, value) {

      if (key.contains(user['id'])) {

        Chat n = new Chat(
            key: key);
        futures.add(loadChat(n));
      }
    });

    await Future.wait(futures);
  }

  @override
  void initState() {
    super.initState();
    getChatUsers().then((value) => print(chats[0].messages));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Text(
                "Chats",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          chats == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : chats.isEmpty
                  ? Center(
                      child:
                          Text('Click on the Message icon to start chatting'),
                    )
                  : ListView.builder(
                      itemCount: chats.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUsersList(
                          chat: chats[index],
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
