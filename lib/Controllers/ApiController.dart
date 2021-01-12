import 'dart:convert';
import 'package:dejamobile_card_app/Models/Pay.dart';
import 'package:dejamobile_card_app/Models/User.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static const String url = "http://192.168.1.100:3000/api";

  // --- {GET} --- //

  static Future getCardsByEmail(String email) {
    var response = http.get(Uri.encodeFull("$url/cards/$email"));
    return response;
  }

  static Future getPaymentsBySenderID(String senderID) {
    var response = http.get(Uri.encodeFull("$url/pay/$senderID"));
    return response;
  }

  // --- {POST} --- //

  static Future addUser(User userData) {
    var response = http.post(Uri.encodeFull("$url/users"),
        body: jsonEncode(userData.toJson()));
    return response;
  }

  static Future addCard(Map<String, dynamic> card) {
    var response = http.post(Uri.encodeFull("$url/cards"),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(card));
    return response;
  }

  static Future addPay(Pay pay) {
    var response = http.post(Uri.encodeFull("$url/pay"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(pay.toJson()));
    return response;
  }

  // --- {PUT} --- //

  static Future login(Map<String, dynamic> rawBody) {
    var response = http
        .put(Uri.encodeFull("$url/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(rawBody))
        .timeout(Duration(seconds: 2));
    return response;
  }

  // --- {DELETE} --- //

  static Future deleteCard(String cardId) {
    var response = http.delete(Uri.encodeFull('$url/card/$cardId'));
    return response;
  }
}
