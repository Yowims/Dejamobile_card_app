import 'package:dejamobile_card_app/Controllers/PayListController.dart';
import 'package:dejamobile_card_app/Models/Pay.dart';
import 'package:dejamobile_card_app/Views/pages/NewPayPage.dart';
import 'package:flutter/material.dart';

class PayListPage extends StatefulWidget {
  final String cardID;

  PayListPage({String cardId}) : cardID = cardId;
  @override
  PayListPageState createState() => new PayListPageState(this.cardID);
}

class PayListPageState extends State<PayListPage> {
  final String cardIDstate;

  PayListPageState([this.cardIDstate]);
  List<Pay> payList = new List<Pay>();
  PayListController plc = PayListController();
  bool isLoading = false;
  TextStyle commentStyle =
      new TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle gain = TextStyle(color: Colors.green);
  TextStyle perte = TextStyle(color: Colors.red);

  displayPayments() async {
    setState(() {
      isLoading = true;
    });
    await plc.getPaymentsByCardID(this.cardIDstate, payList);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    displayPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dejamobile Takehome"),
      ),
      body: SingleChildScrollView(
        child: Column(
          //alignment: WrapAlignment.center,
          children: [
            Container(
              height: 150,
              child: Text(
                "Récapitulatif des paiements pour la carte n°$cardIDstate",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: payList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    child: Card(
                      child: Column(
                        children: [
                          payList[index].comment != ""
                              ? Text(
                                  payList[index].comment,
                                  style: commentStyle,
                                )
                              : Text(
                                  "Non spécifié",
                                  style: commentStyle,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Montant : "),
                              payList[index].senderID != this.cardIDstate
                                  ? Text(
                                      "${payList[index].amount} €",
                                      style: gain,
                                    )
                                  : Text(
                                      "${payList[index].amount} €",
                                      style: perte,
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewPayPage(
                        cardID: cardIDstate,
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
