import 'dart:async';
import 'dart:convert';

import 'package:dejamobile_card_app/Controllers/ApiController.dart';
import 'package:dejamobile_card_app/Views/components/WaitingIndicator.dart';
import 'package:dejamobile_card_app/Views/pages/CardListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  bool isNotEmail(String str) {
    RegExp exp = new RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (exp.hasMatch(str))
      return false;
    else
      return true;
  }

  login(BuildContext context, Map<String, dynamic> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(
        context: context, barrierDismissible: false, child: WaitingIndicator());
    try {
      await ApiController.login(body).then((response) {
        if (response.statusCode != 200) {
          showDialog(
              context: context,
              barrierDismissible: true,
              child: CupertinoAlertDialog(
                title: Text("Erreur"),
                content: Text(response.body),
              )).then((action) {
            Navigator.of(context).pop();
          });
        } else {
          Map<String, dynamic> returned = jsonDecode(response.body);
          prefs.setString("email", returned['email']);
          prefs.setString("passphrase", returned['passphrase']);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CardListPage(userEmail: returned['email'])));
        }
      });
    } on TimeoutException {
      showDialog(
          context: context,
          barrierDismissible: true,
          child: CupertinoAlertDialog(
            title: Text("Erreur"),
            content: Text("Le serveur est injoignable. Réessayez plus tard."),
          )).then((action) {
        Navigator.of(context).pop();
      });
    }
  }
}
