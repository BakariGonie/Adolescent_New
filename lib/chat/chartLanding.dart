import 'package:adolescentfinalyearproject/chat/chatModel.dart';
import 'package:adolescentfinalyearproject/chat/chatUserList.dart';
import 'package:flutter/material.dart';

class ChatLanding extends StatefulWidget {
  @override
  _ChatLandingState createState() => _ChatLandingState();
}

class _ChatLandingState extends State<ChatLanding> {

  List<ChatUser> chatUsers = [
    ChatUser(
        name: "Jane Russel",
        isOnline: true,
        isLastMessageRead: true,
        lastText: "Awesome Setup",
        image: "assets/customer-avatar.png",
        lastTextTime: DateTime.now()),
    ChatUser(
        name: "Glady's Murphy",
        lastText: "That's Great",
        isOnline: true,
        isLastMessageRead: true,
        image: "assets/customer-avatar.png",
        lastTextTime: DateTime.now()),
    ChatUser(
        name: "Jorge Henry",
        lastText: "Hey where are you?",
        isOnline: true,
        isLastMessageRead: true,
        image: "assets/customer-avatar.png",
        lastTextTime: DateTime.now()),
    ChatUser(
        name: "Philip Fox",
        lastText: "Busy! Call me in 20 mins",
        image: "assets/customer-avatar.png",
        isOnline: true,
        isLastMessageRead: false,
        lastTextTime: DateTime.now()),
    ChatUser(
        name: "Debra Hawkins",
        lastText: "Thankyou, It's awesome",
        image: "assets/customer-avatar.png",
        isOnline: true,
        isLastMessageRead: false,
        lastTextTime: DateTime.now()),
    ChatUser(
        name: "Jacob Pena",
        lastText: "will update you in evening",
        image: "assets/customer-avatar.png",
        isOnline: true,
        isLastMessageRead: true,
        lastTextTime: DateTime.now()),
    ChatUser(
        name: "Andrey Jones",
        lastText: "Can you please share the file?",
        image: "assets/customer-avatar.png",
        isOnline: true,
        isLastMessageRead: true,
        lastTextTime: DateTime.now()),
    ChatUser(
        name: "John Wick",
        lastText: "How are you?",
        image: "assets/customer-avatar.png",
        isOnline: true,
        isLastMessageRead: false,
        lastTextTime: DateTime.now()),
  ];

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
                style:
                TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
              ),
            ),
          ),
          ListView.builder(
            itemCount: chatUsers.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatUsersList(
                user: chatUsers[index],
              );
            },
          ),
        ],
      ),

    );
  }
}
