import 'package:adolescentfinalyearproject/chat/chartDetailsPage.dart';
import 'package:adolescentfinalyearproject/chat/chatModel.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

class ChatUsersList extends StatefulWidget{

  final ChatUser user;
  ChatUsersList({@required this.user});
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {

  @override
  Widget build(BuildContext context) {
    ChatUser user = widget.user;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailsPage(user: user,);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(user.image),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(user.name),
                          SizedBox(height: 6,),
                          Text(user.lastText,style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(formatTime(user.lastTextTime.millisecondsSinceEpoch),style: TextStyle(fontSize: 12,color: user.isLastMessageRead?Colors.pink:Colors.grey.shade500),),
          ],
        ),
      ),
    );
  }
}