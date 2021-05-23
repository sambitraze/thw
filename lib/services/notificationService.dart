import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/deviceToken.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class NotificationService {
  static Future subscribeTopTopic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newToken = await messaging.getToken(
        vapidKey:
            "BG8mGeAu8pxrQEYh9ZSz2Vb7az_0jl8x6gcO6uMEEKAu47p6a0MwZjN5g7LBQk1SyrtqxC2psACzcH8PS-Mnzb4");
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/notification/subscribe/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"deviceToken": newToken, "topic": "admin"}),
    );
    if (response.statusCode == 200) {
      prefs.setString("deviceToken", newToken);
      http.Response response = await http.post(
        Uri.parse("https://tandoorhut.co/devicetoken/create"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user": "test", "devicetoken": newToken}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future unsubscribeTopTopic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("deviceToken");
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/notification/unsubscribe/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"deviceToken": token, "topic": "test"}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future unsubscribeEveryone() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/devicetoken/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List<DeviceToken> tokenlist = jsonDecode(response.body)
          .map<DeviceToken>((itemMap) => DeviceToken.fromJson(itemMap))
          .toList();
      List<String> tokens;
      tokenlist.forEach((element) {
        tokens.add(element.devicetoken);
      });
      http.Response response2 = await http.post(
        Uri.parse("https://tandoorhut.co/notification/unsubscribe/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"deviceToken": tokens, "topic": "test"}),
      );
      if (response2.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
