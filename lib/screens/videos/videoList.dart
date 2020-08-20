import 'package:adolescentfinalyearproject/container/consultantsItem.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

import '../../globals.dart';

class VideosPlay extends StatefulWidget {
  @override
  _VideosPlayState createState() => _VideosPlayState();
}

class _VideosPlayState extends State<VideosPlay> {
  DatabaseReference homeRef;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("videos"),
      ),
      body: StreamBuilder(
        stream: homeRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> consultantsItem = snapshot.data.snapshot.value.values.toList()
                .map((val) {
              return ConsultantsItem(
                  val['descriptions'], val['path'],
                  val['timestamp'], val['title']);
            }).toList();
            return ListView.builder(
                itemCount: consultantsItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: consultantsItem[index],
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
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      homeRef = database.reference().child('consultants');
    });
    super.initState();
  }
}
