import 'package:adolescentfinalyearproject/chat/chartDetailsPage.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatefulWidget{
  ChatMessage chatMessage;
  ChatBuble({@required this.chatMessage});
  @override
  _ChatBubleState createState() => _ChatBubleState();
}

class _ChatBubleState extends State<ChatBuble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Receiver?Alignment.topLeft:Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.type  == MessageType.Receiver?Colors.white:Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(16),
          child: Text(widget.chatMessage.message),
        ),
      ),
    );
  }
}