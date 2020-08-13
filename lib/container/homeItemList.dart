import 'package:adolescentfinalyearproject/container/homeItem.dart';
import 'package:flutter/material.dart';

class HomeItemList extends StatefulWidget {
  @override
  _HomeItemListState createState() => _HomeItemListState();
}

class _HomeItemListState extends State<HomeItemList> {
  List<Map> homeItem = [{'title':'bakari','image':'assets/images/picha.jpg','message':'holla holla','author':'nyamihula(PhD)','time':'20:34'}];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: homeItem.length,
        itemBuilder: (BuildContext context, int index){
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: HomeItem(homeItem[index]['title'],homeItem[index]['image'],homeItem[index]['message'],homeItem[index]['author'],homeItem[index]['time']),
      );
    });
  }
}
