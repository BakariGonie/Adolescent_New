import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class VideoItem extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;
  final String path;


  VideoItem(
      this.title, this.path, this.description,this.timestamp);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //height: 300,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                path,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                timestamp,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
