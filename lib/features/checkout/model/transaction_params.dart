class TransactionParams {
  final String? email;
  final String? amount;
  final String? reference;

  TransactionParams({this.email, this.amount, this.reference});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json["email"] = email;
    json["amount"] = amount;
    json["reference"] = reference;

    return json;
  }
}
