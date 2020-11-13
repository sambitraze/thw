import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/order.dart';

class OrderService {
  static Future createOrder(payload) async {
    http.Response response = await http.post(
      "http://localhost:3000/order/create",
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
}
