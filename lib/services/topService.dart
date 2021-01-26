import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/top.dart';

class TopService {
  static Future createTop(payload) async {
    http.Response response = await http.post(
      "http://64.225.85.5/top/create",
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future<List<Top>> getTops() async {
    http.Response response = await http.get(
      "http://64.225.85.5/top/",
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Top> tops =
          responseMap.map<Top>((itemMap) => Top.fromJson(itemMap)).toList();
      return tops; 
    } else {
      print(response.body);
    }
  }

  static Future<bool> updateTop(payload) async {
    http.Response response = await http.put(
      "http://64.225.85.5/top/update",
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}