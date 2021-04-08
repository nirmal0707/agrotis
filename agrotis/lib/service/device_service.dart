import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeviceService {
  Future<void> postToken(String mob) async {
    FirebaseMessaging messaging = FirebaseMessaging();
    String token = await messaging.getToken();
    var ref = FirebaseDatabase.instance.reference().child("Devices");
    ref.child(mob).update({"Token": token});
  }
}
