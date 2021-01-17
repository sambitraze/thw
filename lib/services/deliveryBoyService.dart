import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/deliveryBoy.dart';

class DeliveryBoyService {
  static Future createDeliveryBoy(payload) async {
    http.Response response = await http.post(
      "http://64.225.85.5/deliveryBoy/create",
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      DeliveryBoy deliveryBoy = DeliveryBoy.fromJson(responseMap);
      return deliveryBoy;
    } else {
      print(response.body);
      
    }
  }
  static Future getDeliveryBoyByEmail(email) async {
    http.Response response = await http.post(
      "http://64.225.85.5/deliveryBoy/email",
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      DeliveryBoy deliveryBoy = DeliveryBoy.fromJson(responseMap);
      return deliveryBoy;
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }
  static Future<bool> updateDeliveryBoy(payload) async {
    http.Response response = await http.put(
      "http://64.225.85.5/deliveryBoy/update",
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

  // ignore: missing_return
  static Future<List<DeliveryBoy>> getAllDeliveryBoy() async {
    http.Response response = await http.get(
      "http://64.225.85.5/deliveryBoy/",
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<DeliveryBoy> items =
          responseMap.map<DeliveryBoy>((itemMap) => DeliveryBoy.fromJson(itemMap)).toList();
      return items;
    } else {
      print(response.body);
    }
  }
  static Future getAllUser() async {
    http.Response response = await http.get(
      "http://64.225.85.5/user/",
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      return responseMap.length;
    } else {
      print(response.body);
      return 0;
    }
  }

  
}