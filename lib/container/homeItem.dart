import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';


class HomeItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String message;
  final String authorName;
  final String timeStamp;
  HomeItem(this.title, this.imageUrl, this.message, this.authorName, this.timeStamp);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //height: 300,
        width: MediaQuery.of(context).size.width*0.9,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Image.asset(imageUrl),
              SizedBox(height: 10,),
              ReadMoreText(
                message,style: TextStyle(fontSize: 16,color: Colors.black),textAlign: TextAlign.justify,
                trimLines: 4,
                colorClickableText: Colors.blue,
                trimMode: TrimMode.Line,
                trimCollapsedText: '...Show more',
                trimExpandedText: ' show less',
              ),
              SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [

                      Text('Writen by: ', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16,color: Colors.black54),),
                      Text(authorName, style: TextStyle(fontSize: 16,color: Colors.black54),),
                    ],
                  ),
                  Text(timeStamp,style: TextStyle(color: Colors.black54),)
                ],
              ),
              SizedBox(height: 10.0,)
            ],
          ),
        ),
      ),
    );
  }
}
