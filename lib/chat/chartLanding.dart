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
  DatabaseReference messageRef;

  Future<void> createFuture(Chat chat) async {
    return await chat.getChat();
  }

  List<Chat> getChatUsers(DataSnapshot snapshot) {
    List<Chat> chats = [];

    snapshot.value.forEach((key, value) {
      if (key.contains(user['id'])) {
        Chat n = new Chat(key: key);
        chats.add(n);
      }
    });

//    chats.sort((b, a) => a.messages[a.messages.length - 1].timeStamp
//        .compareTo(b.messages[b.messages.length - 1].timeStamp));
    return chats;
  }

  @override
  void initState() {
    messageRef = database.reference().child('messages');
    super.initState();
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
          StreamBuilder(
              stream: messageRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Chat> chats = getChatUsers(snapshot.data.snapshot);
                  return ListView.builder(
                    itemCount: chats.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatUsersList(
                        chat: chats[index],
                      );
                    },
                  );
                } else if (snapshot.hasData &&
                    snapshot.data.snapshot.values.toList().isEmpty) {
                  return Center(
                    child: Text('Press on the button below to start chatting'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
