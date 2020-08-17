import 'package:adolescentfinalyearproject/container/homeItem.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

import '../globals.dart';

class HomeItemList extends StatefulWidget {
  @override
  _HomeItemListState createState() => _HomeItemListState();
}

class _HomeItemListState extends State<HomeItemList> {
  DatabaseReference homeRef;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: homeRef.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> homeItem = snapshot.data.snapshot.value.values.toList()
              .map((val) {
            return HomeItem(
                val['title'], 'assets/images/picha.jpg', val['article'],
                val['author'], formatTime(val['timestamp']));
          }).toList();
          return ListView.builder(
              itemCount: homeItem.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: homeItem[index],
                );
              });
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState() {
    setState(() {
      homeRef = database.reference().child('articles');
    });
    super.initState();
  }
}
