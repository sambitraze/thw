import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/Item.dart';

class ItemService {
  static Future createItem(payload) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/item/create"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      return Item.fromJson(responsedata);
    } else {
      return false;
    }
  }

  // ignore: missing_return
  static Future<List<Item>> getAllItems() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/item/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Item> items =
          responseMap.map<Item>((itemMap) => Item.fromJson(itemMap)).toList();
      return items;
    } else {
      List<Item> items = [];
      return items;
    }
  }

  static Future<bool> delteItem(id) async {
    http.Response response = await http.delete(
      Uri.parse("https://tandoorhut.co/item/delete/$id"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
