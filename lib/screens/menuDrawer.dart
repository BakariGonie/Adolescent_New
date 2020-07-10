import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MenuDrawer extends StatefulWidget {

  @override
  _MenuDrawerState createState() => new _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final drawerItems = [
    DrawerItem("Homepage", Icons.pageview),
    DrawerItem("Special_centres", Icons.directions),
    DrawerItem("Available_counselors", Icons.people),
    DrawerItem("schedule", Icons.access_time),
    DrawerItem("about_app", Icons.apps),
    DrawerItem("contacts", Icons.phone),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                    d.icon,
                    color: Colors.deepPurple
                ),
                title: Text(
                    d.title,
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold
                    )),
                selected: i == _selectedIndex,
                onTap: () => _onSelectItem(i),
              ),
              Divider(
                color: Colors.deepPurple,
                height: 2.0,
              )

            ],
          )


      );
    }
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("Util.userName"),
            accountEmail: new Text("Util.emailId"),

            currentAccountPicture: new CircleAvatar(
                maxRadius: 24.0,
                backgroundColor: Colors.transparent,
                backgroundImage: ExactAssetImage('assets/customer-avatar.png'),
              // backgroundImage: new Image.network(src),
            ),

          ),
          new Column(
              children: drawerOptions
          ),
        ],
      ),
    );


  }


  _setDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        Navigator.pushNamed(context, "/home");
        break;
      case 1:
        Navigator.pushNamed(context, "/special");
        break;
      case 2:
        Navigator.pushNamed(context, "/available");
        break;
      case 3:
      //Navigator.pushNamed(context, "/available");
        break;
      case 4:
        Navigator.pushNamed(context, "/about");
        break;
      case 5:
        Navigator.pushNamed(context, "/contacts");
        break;
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    _setDrawerItemWidget(index);
    //Navigator.of(context).pop(); // close the drawer

  }

}