import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseApp app;

Map<dynamic, dynamic> consultants;



final FirebaseDatabase database = FirebaseDatabase(app: app);
final DatabaseReference videoRef =  database.reference().child('videos');

Future<DataSnapshot>currentUserInfo(String id) async {
  videoRef.equalTo(id, key: 'id');
  return await videoRef.once();
}