import 'package:adolescentfinalyearproject/screens/constants/colors.dart';
import 'package:adolescentfinalyearproject/screens/constants/gradients.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      body: body(context),
    );
  }

  Widget appBarComponent(context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
          child: Row(
        children: <Widget>[
          Container(
            width: 90,
            height: 80,
            padding: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              gradient: BLUE_GRADIENT,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100)),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: WHITE_COLOR,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      )),
    );
  }

  Widget body(context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: ListView(
        children: <Widget>[
          headerComponent(),
          Container(margin: EdgeInsets.only(top: 40)),
          descriptionComponent(),
          Container(margin: EdgeInsets.only(top: 20)),
          Divider(),
          Container(margin: EdgeInsets.only(top: 40)),
          developerItemComponent(
            "Front-end and Back-end developer",
            "Bakari, Abdillah",
          ),
          Container(margin: EdgeInsets.only(top: 30)),
          developerItemComponent(
            "Designer",
            "Bakari Abdillah",
          )
        ],
      ),
    );
  }

  Widget headerComponent() {
    return Text("About app", style: TextStyle(fontSize: 30));
  }

  Widget descriptionComponent() {
    return Text(
      "This App is all about Adolescents (10-19 yrs) where they can chat with each other, meet the counselor and express"
          "all there problems and get help",
      style: TextStyle(
        fontSize: 19,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget developerItemComponent(
    String role,
    String name,
    ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          role,
          style: TextStyle(fontSize: 18),
        ),
        Container(margin: EdgeInsets.only(top: 5)),
        Row(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 24, color: PALE_ORANGE),
            ),

          ],
        )
      ],
    );
  }

}
