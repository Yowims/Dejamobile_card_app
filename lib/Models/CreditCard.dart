class CreditCard {
  String cardID;
  String ownerEmail;
  String cardInfo;

  CreditCard({this.cardID, this.ownerEmail, this.cardInfo});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      cardID: json['cardID'],
      ownerEmail: json['ownerEmail'],
      cardInfo: json['cardInfo'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'cardID': cardID, 'ownerEmail': ownerEmail, 'cardInfo': cardInfo};
}
