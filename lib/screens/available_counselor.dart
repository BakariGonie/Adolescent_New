import 'package:flutter/material.dart';

class AvailableCounselors extends StatefulWidget {
  @override
  _AvailableCounselorsState createState() => _AvailableCounselorsState();
}

class _AvailableCounselorsState extends State<AvailableCounselors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("available counselor"),
      ),
      body: Container(
        child: Center(
          child: Text("available"),
        ),
      ),
    );
  }
}
