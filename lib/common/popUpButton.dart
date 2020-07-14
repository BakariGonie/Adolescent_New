import 'package:flutter/material.dart';

List<PopUp> popups = <PopUp>[
  const PopUp(title: Text('View Profile'), icon: Icon(Icons.person), id: 0),
  const PopUp(title: Text('Sign Out'), icon: Icon(Icons.input), id: 1),
];

class PopButton extends StatefulWidget {
  final  onPageChange;
  PopButton({this.onPageChange});
  @override
  State<StatefulWidget> createState() {
    return PopButtonState();
  }
}

class PopButtonState extends State<PopButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.menu,
          color: Colors.transparent,
        ),
        elevation: 2,
        onSelected: selected,
        itemBuilder: (BuildContext context) => popups.map((PopUp popUp) {
          return PopupMenuItem(
            value: popUp,
            child: ListTile(
              leading: popUp.icon,
              title: popUp.title,
            ),
          );
        }).toList());
  }

  void selected(PopUp popUp) {
    if (popUp.id == 0) {
      Navigator.pushNamed(context, '/profile');
    }
        if (popUp.id == 1) {


    }
  }
}

class PopUp{
  final Text title;
  final Icon icon;
  final int id;

  const PopUp({this.title, this.icon, this.id});
}
