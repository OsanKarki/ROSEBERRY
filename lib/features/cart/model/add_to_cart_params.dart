class AddToCartParams {
  final String? sku;
  final String? quantity;

  AddToCartParams({required this.sku, required this.quantity});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['sku'] = sku;
    json['qty'] = quantity;
    return json;
  }
}
