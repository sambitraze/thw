import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/order.dart';

class OrderService {
  static Future createOrder(payload) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/order/create"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future updateOrder(payload) async {
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/order/update"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future getAllOrderByCount(skip, limit) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/order/count"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"skip": skip, "limit": limit}),
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      List<Order> orderList = responsedata
          .map<Order>((itemMap) => Order.fromJson(itemMap))
          .toList();
      return orderList;
    } else {
      List<Order> orderList = [];
      return orderList;
    }
  }

  static Future getAllConfirmedOrdersByCount(skip, limit) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/order/confirmed/count"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"skip": skip, "limit": limit}),
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      List<Order> orderList = responsedata
          .map<Order>((itemMap) => Order.fromJson(itemMap))
          .toList();
      return orderList;
    } else {
      List<Order> orderList = [];
      return orderList;
    }
  }

  static Future getAllUnconfirmedOrdersByCount(skip, limit) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/order/unconfirmed/count"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"skip": skip, "limit": limit}),
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      List<Order> orderList = responsedata
          .map<Order>((itemMap) => Order.fromJson(itemMap))
          .toList();
      return orderList;
    } else {
      List<Order> orderList = [];
      return orderList;
    }
  }

  static Future orderCount() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/order/count"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      return responseMap["ordercount"];
    } else {
      return 0;
    }
  }
}
