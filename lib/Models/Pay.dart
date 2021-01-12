class Pay {
  String senderID;
  String recieverID;
  String amount;
  String comment;

  Pay({this.senderID, this.recieverID, this.amount, this.comment});

  factory Pay.fromJson(Map<String, dynamic> json) {
    return Pay(
        senderID: json['senderID'],
        recieverID: json['recieverID'],
        amount: json['amount'],
        comment: json['comment']);
  }

  Map<String, dynamic> toJson() => {
        "senderID": senderID,
        "recieverID": recieverID,
        "amount": amount,
        "comment": comment
      };
}
