import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseApp app;

final FirebaseDatabase database = FirebaseDatabase(app: app);
final DatabaseReference userRef =  database.reference().child('users');

Future<DataSnapshot>currentUserInfo(String id) async {
    userRef.equalTo(id, key: 'id');
    return await userRef.once();
}