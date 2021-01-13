import 'package:dejamobile_card_app/Controllers/PayListController.dart';
import 'package:dejamobile_card_app/Models/CreditCard.dart';
import 'package:dejamobile_card_app/Models/Pay.dart';
import 'package:flutter/material.dart';
import 'package:dejamobile_card_app/Controllers/CardListController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPayPage extends StatefulWidget {
  final String _cardId;
  @override
  NewPayPage({String cardID}) : _cardId = cardID;
  NewPayPageState createState() => new NewPayPageState(this._cardId);
}

class NewPayPageState extends State<NewPayPage> {
  final String _cardIdState;
  NewPayPageState([this._cardIdState]);

  final _key = GlobalKey<FormState>();
  bool isTicked = false;
  bool isLoading = false;
  final List<DropdownMenuItem<String>> myCardsList =
      List<DropdownMenuItem<String>>();
  String selectedCardNumber;
  String amount;
  String comment;
  CardListController clc = new CardListController();
  PayListController plc = new PayListController();
  SharedPreferences prefs;
  List<CreditCard> myCards = new List<CreditCard>();

  Widget cardWidget;

  populateCards() async {
    prefs = await SharedPreferences.getInstance();
    await clc.getMyCards(prefs.getString('email'), myCards);
    for (CreditCard i in myCards) {
      if (i.cardID != _cardIdState)
        myCardsList.add(DropdownMenuItem(
          value: i.cardID,
          child: Text(i.cardID),
        ));
    }
    setState(() {
      isLoading = false;
    });
  }

  recieverWidget(BuildContext context) {
    if (isTicked == false) {
      setState(() {
        cardWidget = TextFormField(
          decoration: InputDecoration(hintText: "N° de carte du destinataire"),
          validator: (value) {
            if (value.isEmpty) return "Le champ ne doit pas être vide.";
            selectedCardNumber = value;
            return null;
          },
        );
      });
    } else {
      setState(() {
        cardWidget = DropdownButtonFormField(
          decoration: InputDecoration(hintText: "Choisissez votre compte"),
          onChanged: (value) {
            selectedCardNumber = value;
          },
          items: myCardsList,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    populateCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nouveau paiement")),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: cardWidget != null
                      ? cardWidget
                      : TextFormField(
                          decoration: InputDecoration(
                              hintText: "N° de carte du destinataire"),
                          validator: (cardVal) {
                            if (cardVal.isEmpty)
                              return "Le champ ne doit pas être vide.";
                            selectedCardNumber = cardVal;
                            return null;
                          },
                        ),
                ),
              ),
              SizedBox(height: 80),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Montant"),
                    validator: (amountVal) {
                      if (amountVal.isEmpty)
                        return "Le champ ne doit pas être vide.";
                      amount = amountVal;
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 80),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: "Commentaire (facultatif)"),
                    validator: (commentVal) {
                      commentVal.isNotEmpty
                          ? comment = commentVal
                          : comment = "";
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 80),
              RaisedButton(
                child: Text('Valider'),
                onPressed: () {
                  Pay pay = Pay.fromJson({
                    "senderID": _cardIdState,
                    "recieverID": selectedCardNumber,
                    "amount": amount,
                    "comment": comment
                  });
                  if (_key.currentState.validate()) {
                    plc.addPayment(pay, context, _cardIdState);
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          alignment: Alignment.centerLeft,
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  'Vers vos comptes',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Checkbox(
                  activeColor: Colors.blue,
                  value: isTicked,
                  onChanged: (arg) {
                    isTicked = arg;
                    setState(() {
                      recieverWidget(context);
                    });
                  },
                )
              ],
            ),
          )),
    );
  }
}
