import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/Item.dart';

class ItemService {
  static Future createItem(payload) async {
    http.Response response = await http.post(
      "http://64.225.85.5/item/create",
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      return Item.fromJson(responsedata);
    } else {
      print(response.body);
      return false;
    }
  }

  // ignore: missing_return
  static Future<List<Item>> getAllItems() async {
    http.Response response = await http.get(
      "http://64.225.85.5/item/",
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Item> items =
          responseMap.map<Item>((itemMap) => Item.fromJson(itemMap)).toList();
      return items;
    } else {
      print(response.body);
    }
  }

  static Future<bool> delteItem(id) async {
    http.Response response = await http.delete(
      "http://64.225.85.5/item/delete/$id",
      headers: {"Content-Type": "application/json"},
    );
    var decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      print(decodedResponse);
      return false;
    }
  }
}
