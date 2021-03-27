class Payments {
  String customerID;
  String amount;
  String date;
  String service;
  Payments({this.customerID, this.service, this.amount, this.date});

  List<Payments> getPayments() {
    return [];
  }
}
