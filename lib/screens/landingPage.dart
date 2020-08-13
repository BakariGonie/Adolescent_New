import 'package:adolescentfinalyearproject/chat/chartLanding.dart';
import 'package:adolescentfinalyearproject/chat/chatModel.dart';
import 'package:adolescentfinalyearproject/chat/chatUserList.dart';
import 'package:adolescentfinalyearproject/chat/usersList.dart';
import 'package:adolescentfinalyearproject/common/popUpButton.dart';
import 'package:adolescentfinalyearproject/container/homeItemList.dart';
import 'package:adolescentfinalyearproject/screens/mapPinPointDirectives.dart';
import 'package:adolescentfinalyearproject/screens/menuDrawer.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController _pageController;
  int _pageIndex = 0;

  List<Widget> _widgets = <Widget>[
    HomeItemList(),
    MapPinPointDirectives(),
    ChatLanding(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
//    _pageController.animateToPage(page,
//        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      this._pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Adolescent counseling"),
        actions: [
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 45),
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundImage:
                          ExactAssetImage('assets/customer-avatar.png'),
                    ),
                  ),
                ),
                Center(
                  child: PopButton(
                    onPageChange: (index) {
                      setState(() {
                        _pageController.jumpToPage(index);
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: MenuDrawer(),
      body: PageView(
        onPageChanged: onPageChanged,
        controller: _pageController,
        children: _widgets,
      ),
      floatingActionButton: _pageIndex==2?FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.message),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> UserList()));
        },
      ):null,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
        ), // sets the inactive color of the `BottomNavigationBar`

        child: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.home,
                  color: _pageIndex != 0
                      ? Color(0xFFFFFFFF)
                      : Theme.of(context).buttonColor,
                ),
                title: new Text(
                  "Home",
                  style: new TextStyle(
                    color: _pageIndex != 0
                        ? Color(0xFFFFFFFF)
                        : Theme.of(context).buttonColor,
                  ),
                )),
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.directions,
                  color: _pageIndex != 1
                      ? Color(0xFFFFFFFF)
                      : Theme.of(context).buttonColor,
                ),
                title: new Text(
                  "Directive",
                  style: new TextStyle(
                    color: _pageIndex != 1
                        ? Color(0xFFFFFFFF)
                        : Theme.of(context).buttonColor,
                  ),
                )),
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.chat,
                  color: _pageIndex != 2
                      ? Color(0xFFFFFFFF)
                      : Theme.of(context).buttonColor,
                ),
                title: new Text(
                  "ChatBox",
                  style: new TextStyle(
                    color: _pageIndex != 2
                        ? Color(0xFFFFFFFF)
                        : Theme.of(context).buttonColor,
                  ),
                )),
          ],
          onTap: navigationTapped,
          currentIndex: _pageIndex,
        ),

      ),
    );
  }
}
