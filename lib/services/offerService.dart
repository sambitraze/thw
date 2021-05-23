import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/offers.dart';

class OfferService {
  static Future createOffer(payload) async {
    http.Response response = await http.post(
      Uri.parse("s://tandoorhut.co/offer/create"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      return Offer.fromJson(responsedata);
    } else {
      return false;
    }
  }

  // ignore: missing_return
  static Future<List<Offer>> getOffers() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/offer/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Offer> offers =
          responseMap.map<Offer>((itemMap) => Offer.fromJson(itemMap)).toList();
      return offers;
    } else {
      List<Offer> offers = [];
      return offers;
    }
    // ignore: missing_return
  }

  static Future<List<Offer>> getUnBlockedOffers() async {
    http.Response response = await http.get(
      Uri.parse("https://tandoorhut.co/offer/unblocked"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Offer> offers =
          responseMap.map<Offer>((itemMap) => Offer.fromJson(itemMap)).toList();
      return offers;
    } else {
      List<Offer> offers = [];
      return offers;
    }
  }

  static Future<bool> updateOffer(payload) async {
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/offer/update"),
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
