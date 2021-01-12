import 'dart:convert';

import 'package:dejamobile_card_app/Controllers/ApiController.dart';
import 'package:dejamobile_card_app/Models/CreditCard.dart';
import 'package:dejamobile_card_app/Views/components/WaitingIndicator.dart';
import 'package:dejamobile_card_app/Views/pages/CardListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardListController {
  SharedPreferences prefs;
  notValid(String value, int nb) {
    if (value.length != nb) {
      return true;
    } else
      return false;
  }

  incChars(String value) {
    RegExp reg = new RegExp(r"^[^\w\-\']+$");
    if (reg.hasMatch(value)) {
      return true;
    }
    return false;
  }

  wrongFormat(String value) {
    RegExp reg = new RegExp(r"^([0-90-9-0-90-90-90-9])+$");
    if (reg.hasMatch(value) && value.length == 7) {
      return false;
    }
    return true;
  }

  getMyCards(String email, List<CreditCard> myCards) async {
    await ApiController.getCardsByEmail(email).then((response) {
      var result = jsonDecode(response.body);
      for (var item in result) {
        CreditCard card = CreditCard.fromJson(item);
        myCards.add(card);
      }
    });
  }

  addNewCard(Map<String, dynamic> cardInfo, BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    showDialog(
        context: context, barrierDismissible: false, child: WaitingIndicator());
    await ApiController.addCard(cardInfo).then((response) {
      if (response.statusCode == 201) {
        Fluttertoast.showToast(
            msg: "Carte ajoutée!", toastLength: Toast.LENGTH_SHORT);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CardListPage(
                      userEmail: prefs.getString('email'),
                    )));
      } else
        showDialog(
            context: context,
            barrierDismissible: true,
            child: CupertinoAlertDialog(
              title: Text("Erreur"),
              content: Text(response.body),
            )).then((action) {
          Navigator.of(context).pop();
        });
    });
  }
}
