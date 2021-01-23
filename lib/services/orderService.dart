import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/order.dart';

class OrderService {
  static Future createOrder(payload) async {
    http.Response response = await http.post(
      "http://64.225.85.5/order/create",
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      print(responsedata);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
  static Future updateOrder(payload) async {
    http.Response response = await http.put(
      "http://64.225.85.5/order/update",
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      print(responsedata);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future getAllOrders() async {
    http.Response response = await http.get(
      "http://64.225.85.5/order/",
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      List<Order> orderList = responsedata.map<Order>((itemMap) => Order.fromJson(itemMap)).toList();
      return orderList;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future getAllOrdersByCount(skip, limit) async {
    http.Response response = await http.post(
      "http://64.225.85.5/order/count",
      headers: {"Content-Type": "application/json"},  body: jsonEncode({"skip":skip, "limit": limit}),
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      List<Order> orderList = responsedata.map<Order>((itemMap) => Order.fromJson(itemMap)).toList();
      return orderList;
    } else {
      print(response.body);
      return false;
    }
  } 
}
