import 'package:dejamobile_card_app/Controllers/CardListController.dart';
import 'package:dejamobile_card_app/Models/CreditCard.dart';
import 'package:dejamobile_card_app/Views/pages/HomePage.dart';
import 'package:dejamobile_card_app/Views/pages/NewCardPage.dart';
import 'package:dejamobile_card_app/Views/pages/PayListPage.dart';
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

  Widget cardWidget(BuildContext context) {
    if (myCards.length != 0) {
      return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: myCards.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PayListPage(
                                cardId: myCards[index].cardID,
                              )));
                },
                child: Container(
                  height: 100,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Carte n°${index + 1}",
                          style: TextStyle(
                              fontSize: 46, fontWeight: FontWeight.bold),
                        ),
                        Text("Numéro de carte : ${myCards[index].cardID}")
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Vous n'avez pas encore enregistré de carte."),
            Text(
                'Vous pourrez le faire en tapant sur le "+" en bas de l\'écran.')
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => HomePage()), (e) => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dejamobile Takehome"),
        ),
        body: cardWidget(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewCardPage()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
