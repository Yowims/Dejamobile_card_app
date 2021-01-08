import 'dart:convert';

import 'package:dejamobile_card_app/Controllers/ApiController.dart';
import 'package:dejamobile_card_app/Models/CreditCard.dart';

class CardListController {
  getMyCards(String email, List<CreditCard> myCards) async {
    await ApiController.getCardsByEmail(email).then((response) {
      var result = jsonDecode(response.body);
      for (var item in result) {
        CreditCard card = CreditCard.fromJson(item);
        myCards.add(card);
      }
    });
  }
}
