import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/top.dart';

class TopService {
  static Future createTop(payload) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/top/create"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future getTops() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/top/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Top> tops =
          responseMap.map<Top>((itemMap) => Top.fromJson(itemMap)).toList();
      return tops;
    } else {
      List<Top> tops = [];
      return tops;
    }
  }

  static Future<bool> updateTop(payload) async {
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/top/update"),
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
