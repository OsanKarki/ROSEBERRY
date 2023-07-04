class OrderData {
  final String? email;
  final String? amount;
  final String? reference;

  OrderData({this.email, this.amount, this.reference});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      email: json['email'],
      amount: json['amount'].toString(),
      reference: json['reference'],
    );
  }
}
