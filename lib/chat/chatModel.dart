import 'dart:async';

import 'package:adolescentfinalyearproject/chat/chartDetailsPage.dart';
import 'package:adolescentfinalyearproject/chat/globalConsultants.dart';
import 'package:adolescentfinalyearproject/container/consultants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../globals.dart';

class ChatUsers {
  String text;
  String secondaryText;
  String image;
  String time;

  ChatUsers(
      {@required this.text,
      @required this.secondaryText,
      @required this.image,
      @required this.time});
}

class ChatUser {
  String name;
  bool isOnline;
  String image = "";
  String lastText;
  DateTime lastTextTime;
  bool isLastMessageRead;

  ChatUser(
      {@required this.name,
      @required this.isOnline,
      @required this.image,
      this.lastText,
      this.lastTextTime,
      this.isLastMessageRead});
}

class Chat {
  String user1;
  String user2;
  final String key;

  ChatUser profile1;
  ChatUser profile2;

  DatabaseReference messageRef;

  List<ChatMessage> messages = [];

  Chat({this.key}) {
    String u1, u2;
    messageRef = database.reference().child('messages');
    messageRef.keepSynced(true);
    u1 = key.substring(0, 28);
    u2 = key.substring(28);

    if (user['id'] == u1) {
      user2 = u2;
      user1 = u1;
    } else {
      user2 = u1;
      user1 = u2;
    }
  }

  Future<void> getChat() async {
    DataSnapshot snapshot =
        await consultantsRef.child(user2).once();
    var d = snapshot.value;
    print(d);
    profile2 = new ChatUser(
        name: '${d['firstName']} ${d['lastName']}', isOnline: true, image: "assets/customer-avatar.png");
    profile1 = new ChatUser(
        name: '${user['firstName']} ${user['lastName']}',
        isOnline: true,
        image: "assets/customer-avatar.png");
    //Get all the messages with the sender and id sorting them with their timestamps
    DataSnapshot msgSnapshot = await messageRef.child(key).once();
    Map<dynamic, dynamic> chat = msgSnapshot.value;
    if (chat == null) {
      createChat();
    } else {
      List<dynamic> dbMessages = chat.values.toList();
      dbMessages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

      messages = dbMessages.map((msg) {
        print("Sender");
        print(msg["sender"]);
        return new ChatMessage(
            message: msg['message'],
            type: user1 == msg['sender']
                ? MessageType.Sender
                : MessageType.Receiver,
            timeStamp:
                new DateTime.fromMillisecondsSinceEpoch(msg['timestamp']));
      }).toList();
    }
  }

  Future<void> createChat() async {
    await messageRef.child(key).push().set({});
  }

  Stream<Event> getChatStream() {
    return messageRef.child(key).onValue;
  }

  List<ChatMessage> getMessagesFromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> chat = snapshot.value;
    if (chat == null) {
      createChat();
      return messages;
    } else {
      List<dynamic> dbMessages = chat.values.toList();
      dbMessages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

      return dbMessages.map((msg) {
        return new ChatMessage(
            message: msg['message'],
            type: user1 == msg['sender']
                ? MessageType.Sender
                : MessageType.Receiver,
            timeStamp:
                new DateTime.fromMillisecondsSinceEpoch(msg['timestamp']));
      }).toList();
    }
  }

  Future<void> sendMessage(String message) async {
    var msg = {
      'message': message,
      'receiver': user2,
      'sender': user1,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    await messageRef.child(key).push().set(msg);
  }
}
