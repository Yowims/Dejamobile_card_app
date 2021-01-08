import 'dart:convert';

import 'package:dejamobile_card_app/Controllers/ApiController.dart';
import 'package:dejamobile_card_app/Views/pages/CardListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthController {
  bool isNotEmail(String str) {
    RegExp exp = new RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (exp.hasMatch(str))
      return false;
    else
      return true;
  }

  login(BuildContext context, Map<String, dynamic> body) async {
    await ApiController.login(body).then((response) {
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            barrierDismissible: true,
            child: CupertinoAlertDialog(
              title: Text("Erreur"),
              content: Text(response.body),
            ));
      } else {
        Map<String, dynamic> returned = jsonDecode(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CardListPage(userEmail: returned['email'])));
      }
    });
  }
}
