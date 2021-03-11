class Payments {
  String customerID;
  String amount;
  String date;
  Payments({this.customerID, this.amount, this.date});

  List<Payments> getPayments() {
    return [
      Payments(
          customerID: "CUS001", amount: "2100", date: "21-01-2021 3:00 PM"),
      Payments(customerID: "CUS002", amount: "250", date: "01-01-2021 4:00 PM"),
      Payments(customerID: "CUS003", amount: "450", date: "04-03-2021 6:30 PM"),
      Payments(
          customerID: "CUS004", amount: "1000", date: "21-01-2021 9:00 AM"),
      Payments(customerID: "CUS005", amount: "350", date: "25-01-2021 3:00PM")
    ];
  }
}
