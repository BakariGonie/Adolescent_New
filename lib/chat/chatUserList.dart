import 'package:adolescentfinalyearproject/chat/chartDetailsPage.dart';
import 'package:adolescentfinalyearproject/chat/chatModel.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

class ChatUsersList extends StatefulWidget {
  final Chat chat;

  ChatUsersList({@required this.chat});

  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  Chat chat;

  @override
  void initState() {
    setState(() {
      chat = widget.chat;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailsPage(
            chat: chat,
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(chat.profile2.image),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(chat.profile2.name),
                          SizedBox(
                            height: 6,
                          ),
                          chat.messages.isNotEmpty
                              ? Text(
                                  chat.messages[chat.messages.length - 1]
                                      .message,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            chat.messages.isNotEmpty
                ? Text(
                    formatTime(chat.messages[chat.messages.length - 1].timeStamp
                        .millisecondsSinceEpoch),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
