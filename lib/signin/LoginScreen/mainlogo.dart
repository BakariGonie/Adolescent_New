import 'package:flutter/material.dart';

Widget mainLogo() {
  return
    CircleAvatar(
      radius: 90,
      backgroundColor: Color(0xffFDCF09),
      child: CircleAvatar(
        radius: 85,
        backgroundImage: AssetImage('assets/logo.jpg'),
      ),
    );
}