class InitiateTransactionModel {
  final String? authorizationUrl;
  final String? accessCode;
  final String? reference;

  InitiateTransactionModel(
      {this.reference, this.accessCode, this.authorizationUrl});

  factory InitiateTransactionModel.fromJson(Map<String, dynamic> json) {
    return InitiateTransactionModel(
      authorizationUrl: json["authorization_url"],
      accessCode: json["access_code"],
      reference: json["reference"],
    );
  }
}
