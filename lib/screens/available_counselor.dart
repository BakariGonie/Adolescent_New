import 'package:adolescentfinalyearproject/container/consultantsItem.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

import 'package:adolescentfinalyearproject/container/consultants.dart';

class AvailableCounselor extends StatefulWidget {
  @override
  _AvailableCounselorState createState() => _AvailableCounselorState();
}

class _AvailableCounselorState extends State<AvailableCounselor> {
  DatabaseReference homeRef;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("available counselor"),
        ),
    body: StreamBuilder(
      stream: homeRef.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> consultantsItem = snapshot.data.snapshot.value.values.toList()
              .map((val) {
            return ConsultantsItem(
                val['firstName'], val['lastName'],
                val['email'], val['role']);
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
