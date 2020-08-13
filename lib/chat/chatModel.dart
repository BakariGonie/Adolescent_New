import 'package:flutter/cupertino.dart';

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
  String image;
  String lastText;
  DateTime lastTextTime;
  bool isLastMessageRead;

  ChatUser(
      {@required this.name, @required this.isOnline, @required this.image, this.lastText, this.lastTextTime, this.isLastMessageRead});
}

class Chat{
  final String chatId;
  
  List<Map<String, dynamic>> messages = [];

  Chat({this.chatId});

  void getChat(){
    //Get all the messages with the sender and id sorting them with their timestamps

  }


}