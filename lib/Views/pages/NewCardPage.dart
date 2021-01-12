import 'package:dejamobile_card_app/Controllers/CardListController.dart';
import 'package:dejamobile_card_app/Models/CreditCardInfo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewCardPage extends StatefulWidget {
  @override
  NewCardPageState createState() => new NewCardPageState();
}

class NewCardPageState extends State<NewCardPage> {
  final _key = GlobalKey<FormState>();
  CreditCardInfo newCardInfo = new CreditCardInfo();
  CardListController clc = new CardListController();
  SharedPreferences prefs;

  getCachedValues() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
    print(prefs.getString('passphrase'));
  }

  @override
  void initState() {
    super.initState();
    getCachedValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouvelle carte"),
      ),
      body: Form(
        key: _key,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            //NUMERO DE CARTE
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Numéro de carte",
              ),
              validator: (cardValue) {
                if (cardValue.isEmpty) return "Le champ ne doit pas être vide.";
                if (clc.notValid(cardValue, 16))
                  return "Ce champ doit contenir 16 chiffres.";
                newCardInfo.cardID = cardValue;
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Nom du propriétaire"),
              validator: (nameValue) {
                if (nameValue.isEmpty) return "Le champ ne doit pas être vide";
                if (clc.incChars(nameValue))
                  return "Un nom ne contient pas de caractères spéciaux.";
                newCardInfo.ownerName = nameValue;
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Date d'expiration"),
              validator: (dateValue) {
                if (dateValue.isEmpty) return "Le champ ne doit pas être vide.";
                if (clc.wrongFormat(dateValue))
                  return "La date doit s'écrire comme suit : mm-yyyy";
                newCardInfo.expDate = dateValue;
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Crpytogramme visuel"),
              validator: (cValue) {
                if (cValue.isEmpty) return "Le champ ne doit pas être vide.";
                if (clc.notValid(cValue, 3)) return "3 chiffres demandés.";
                newCardInfo.crypto = cValue;
                return null;
              },
            ),
            RaisedButton(
              onPressed: () {
                Map<String, dynamic> cardData = newCardInfo.toJson();
                cardData['ownerEmail'] = prefs.getString('email');
                if (_key.currentState.validate()) {
                  clc.addNewCard(cardData, context);
                }
              },
              child: Text("Ajouter"),
            )
          ],
        ),
      ),
    );
  }
}
