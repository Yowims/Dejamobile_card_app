import 'dart:convert';

import 'package:dejamobile_card_app/Controllers/ApiController.dart';
import 'package:dejamobile_card_app/Models/Pay.dart';
import 'package:dejamobile_card_app/Views/pages/PayListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PayListController {
  getPaymentsByCardID(String senderID, List<Pay> payList) async {
    await ApiController.getPaymentsBySenderID(senderID).then((response) {
      var result = jsonDecode(response.body);
      for (var i in result) {
        Pay pay = Pay.fromJson(i);
        payList.add(pay);
      }
    });
  }

  addPayment(Pay pay, BuildContext context) async {
    await ApiController.addPay(pay).then((response) {
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Paiement pris en compte.");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PayListPage()));
      } else {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text("Erreur"),
                content: Text(response.body),
              );
            }).then((action) {
          Navigator.of(context).pop();
        });
      }
    });
  }
}
