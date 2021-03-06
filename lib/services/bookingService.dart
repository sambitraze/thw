import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tandoorhutweb/models/booking.dart';

class BookingService {
  static Future getTodayBooking(date) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/booking/today"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(({"date": date})),
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      List<Booking> orderList = responseData
          .map<Booking>((itemMap) => Booking.fromJson(itemMap))
          .toList();
      return orderList;
    } else {
      return false;
    }
  }

  static Future getPastBookingByCount(skip, limit, date) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/booking/past"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"skip": skip, "limit": limit, "date": date}),
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      List<Booking> orderList = responseData
          .map<Booking>((itemMap) => Booking.fromJson(itemMap))
          .toList();
      return orderList;
    } else {
      return false;
    }
  }

  static Future bookingCount() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/booking/count"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      return responseMap["bookingCount"];
    } else {
      return 0;
    }
  }
}
