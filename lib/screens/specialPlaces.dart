import 'package:flutter/material.dart';

class SpecialPlaces extends StatefulWidget {
  @override
  _SpecialPlacesState createState() => _SpecialPlacesState();
}

class _SpecialPlacesState extends State<SpecialPlaces> {
  final List<String> specialPlaces = <String>['Marie Stopes Tanzania', 'Kigamboni Sober house', 'South beach sober house', 'Dawati la jinsia na watoto'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Special places"),
      ),
      body: Container(
        padding: new EdgeInsets.all(32.0),child: new Center(
        child: new Column(
            children: <Widget>[
              new Text('names', style: new TextStyle(fontWeight: FontWeight.bold),),

              new Expanded(child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: specialPlaces.length,
                  itemBuilder: (BuildContext contex, int index){
                    return new Text(specialPlaces.elementAt(index));
                  }
              ),
              ),]
        ),
      ),
      ),

    );
  }
}