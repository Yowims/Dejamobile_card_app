import 'package:dejamobile_card_app/Controllers/CardListController.dart';
import 'package:dejamobile_card_app/Models/CreditCard.dart';
import 'package:flutter/material.dart';

class CardListPage extends StatefulWidget {
  final String _userEmail;
  CardListPage({String userEmail}) : _userEmail = userEmail;
  @override
  CardListPageState createState() => new CardListPageState(this._userEmail);
}

class CardListPageState extends State<CardListPage> {
  final String _userEmailState;
  CardListPageState([this._userEmailState]);
  bool isLoading = false;
  int totalCards;
  CardListController clc = new CardListController();
  List<CreditCard> myCards = new List<CreditCard>();

  displayCards() async {
    setState(() {
      isLoading = true;
    });
    await clc.getMyCards(_userEmailState, myCards);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    displayCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dejamobile Takehome"),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: myCards.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    Text("Carte n°${index + 1}"),
                    Text(myCards[index].cardID)
                  ],
                ),
              );
            }));
  }
}
