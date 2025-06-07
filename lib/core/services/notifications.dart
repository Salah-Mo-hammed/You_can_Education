import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final _messaging = FirebaseMessaging.instance;

  Future<void> initFirebaseMessaging(String centerId) async {
    await _messaging.requestPermission();

    // Subscribe to topic
    await _messaging.subscribeToTopic('center_$centerId');

    // Optional: Handle foreground notifications
    FirebaseMessaging.onMessage.listen((message) {
      print("📩 New notification: ${message.notification?.title}");
    });
  }

  Future<void> notifyCenter(String centerId, String courseName) async {
  const serverKey = 'AIzaSyDlZUiN61HjEZe6AA1s2KVNKZFLaCIKxDI'; // from Firebase Console

  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final body = {
    "to": "/topics/center_$centerId",
    "notification": {
      "title": "New Course Request",
      "body": "A student requested to enroll in $courseName",
    },
    "data": {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "courseId": "some_id",
    }
  };

  await http.post(url, headers: headers, body: jsonEncode(body));
}

}