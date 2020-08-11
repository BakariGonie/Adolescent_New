import 'package:adolescentfinalyearproject/container/homeItemList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    DrawerItem("about_app", Icons.apps),
    DrawerItem("contacts", Icons.phone),
    DrawerItem("schedule", Icons.access_time),
  ];
  Map<String, dynamic> _useData = Map<String, dynamic>();
  bool _fetchingData = true;
  Future<void> _getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _useData['name'] = prefs.get('name');
        _useData['email'] = prefs.get('email');
        _fetchingData = false;
      });
    }catch(e) {
    }
  }

  int _selectedIndex = 0;
  @override
  void initState() {
    _getUserData();
    super.initState();
  }

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
            accountName: new Text(_useData['name']),
            accountEmail: new Text(_useData['email']),

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
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeItemList()),);
        break;
      case 1:
        Navigator.pushNamed(context, "/special");
        break;
      case 2:
        Navigator.pushNamed(context, "/available");
        break;
      case 3:
        Navigator.pushNamed(context, "/about");
        break;
      case 4:
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