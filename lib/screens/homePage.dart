import 'package:adolescentfinalyearproject/container/homeItemList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150,
      width: 150,
      child: FlatButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeItemList()),);
        },
        child: Text("HOME PAGE"),
      ),
    );
  }
}
