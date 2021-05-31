import 'dart:convert';
import 'package:http/http.dart' as http;

class PushService {

  static Future<String> sendPushToUser(
      String title, String message, String id) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode(
      {"title": title, "message": message, "deviceToken": id},
    );
    http.Response response = await http.post(
        Uri.parse("https://tandoorhut.co/notification/singleDevice"),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
