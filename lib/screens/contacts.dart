
import 'package:adolescentfinalyearproject/screens/constants/colors.dart';
import 'package:adolescentfinalyearproject/screens/constants/gradients.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts extends StatelessWidget {
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
          Container(margin: EdgeInsets.only(top: 20)),
          Divider(),
          Container(margin: EdgeInsets.only(top: 40)),
          developerItemComponent(
            "Mobile app developer",
            "Abdillah Bakari ",
                "+255689719837",
            github: "https://github.com/BakariGonie",
            linkedIn: "https://www.linkedin.com/in/Abdillah Bakari/",
          ),
          Container(margin: EdgeInsets.only(top: 30)),
          developerItemComponent(
            "Website developer",
            "Samike Domitila",
            "+255679777995",
            github: "https://github.com/SamikeDomitila/",
            linkedIn: "https://www.linkedin.com/in/SamikeDomitila/",
          )
        ],
      ),
    );
  }

  Widget headerComponent() {
    return Text("Contacts", style: TextStyle(fontSize: 36));
  }

  Widget developerItemComponent(
      String role,
      String name, String phone, {
        String linkedIn,
        String github,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          role,
          style: TextStyle(fontSize: 18),
        ),
        Container(margin: EdgeInsets.only(top: 5)),
        Column(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 24, color: PALE_ORANGE),
            ),
            Text(
              phone,
              style: TextStyle(fontSize: 24, color: PALE_ORANGE),
            ),
            //Expanded(child: Container()),
            IconButton(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/linkedin_ic.png",
                  width: 26,
                  height: 26,
                ),
              ),
              onPressed: () => launchURL(linkedIn),
            ),
            Container(margin: EdgeInsets.only(left: 5)),
            IconButton(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/github_ic.png",
                  width: 26,
                  height: 26,
                ),
              ),
              onPressed: () async {
                await launchURL(github);
              },
            )
          ],
        )
      ],
    );
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}