class PaymentModel{
  final String? label;
  final String? value;

  PaymentModel({this.label,this.value});

  factory PaymentModel.fromJson(Map<String,dynamic>json){
    return PaymentModel(
      label: json["label"],
      value: json["value"],
    );
  }
}