class CreditCardInfo {
  String cardID;
  String ownerName;
  String expDate;
  String crypto;

  CreditCardInfo({this.cardID, this.crypto, this.expDate, this.ownerName});

  factory CreditCardInfo.fromJson(Map<String, dynamic> json) {
    return CreditCardInfo(
        cardID: json['cardID'],
        ownerName: json['ownerName'],
        expDate: json['expDate'],
        crypto: json['crypto']);
  }

  Map<String, dynamic> toJson() => {
        'cardID': cardID,
        'ownerName': ownerName,
        'expDate': expDate,
        'crypto': crypto
      };
}
