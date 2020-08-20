import 'package:adolescentfinalyearproject/container/consultants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../globals.dart';

FirebaseApp app;

//Map<dynamic, dynamic> user;



final DatabaseReference consultantsRef =  database.reference().child('consultants');

Future<DataSnapshot>currentUserInfo(String id) async {
  consultantsRef.equalTo(id, key: 'id');
  return await consultantsRef.once();
}