import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

FirebaseMessaging messaging = FirebaseMessaging.instance;

class NotificationService {
  static Future subscribeTopTopic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newToken = await messaging.getToken(
        vapidKey:
            "BG8mGeAu8pxrQEYh9ZSz2Vb7az_0jl8x6gcO6uMEEKAu47p6a0MwZjN5g7LBQk1SyrtqxC2psACzcH8PS-Mnzb4");
    http.Response response = await http.post(
      Uri.parse("http://64.225.85.5/notification/subscribe/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"deviceToken": newToken, "topic": "admin"}),
    );
    if (response.statusCode == 200) {
      prefs.setString("deviceToken", newToken);
      return true;
    } else {
      return false;
    }
    // if (token != newToken || token == null) {
    //   prefs.setString("deviceToken", newToken);
    //   http.Response response = await http.post(
    //     Uri.parse("http://64.225.85.5/notification/subscribe/"),
    //     headers: {"Content-Type": "application/json"},
    //     body: jsonEncode({"deviceToken": newToken, "topic": "admin"}),
    //   );
    //   if (response.statusCode == 200) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } else {
    //   return true;
    // }
  }

  static Future unsubscribeTopTopic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("deviceToken");
    http.Response response = await http.post(
      Uri.parse("http://64.225.85.5/notification/unsubscribe/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"deviceToken": token, "topic": "admin"}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
