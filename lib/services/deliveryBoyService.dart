import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/deliveryBoy.dart';

class DeliveryBoyService {
  static Future createDeliveryBoy(payload) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/deliveryBoy/create"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      DeliveryBoy deliveryBoy = DeliveryBoy.fromJson(responseMap);
      return deliveryBoy;
    } else {}
  }

  static Future getDeliveryBoyByEmail(email) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/deliveryBoy/email"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      DeliveryBoy deliveryBoy = DeliveryBoy.fromJson(responseMap);
      return deliveryBoy;
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<bool> updateDeliveryBoy(payload) async {
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/deliveryBoy/update"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // ignore: missing_return
  static Future<List<DeliveryBoy>> getAllDeliveryBoy() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/deliveryBoy/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<DeliveryBoy> items = responseMap
          .map<DeliveryBoy>((itemMap) => DeliveryBoy.fromJson(itemMap))
          .toList();
      return items;
    } else {}
  }

  static Future getAllUser() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/user/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      return responseMap.length;
    } else {
      return 0;
    }
  }

  static Future userCount() async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/user/count"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      return responseMap["usercount"];
    } else {
      return 0;
    }
  }

  static Future deliveryBoyCount() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/deliveryBoy/count"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      return responseMap["deliverycount"];
    } else {
      return 0;
    }
  }
}
