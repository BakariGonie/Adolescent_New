import 'package:adolescentfinalyearproject/screens/videos/videoList.dart';
import 'package:flutter/material.dart';

import 'package:adolescentfinalyearproject/container/homeItemList.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        VideosPlay(),
      ],
    );
  }
}
