class UpdateCartItemParams {
  final String? sku;
  final String? quantity;
  final String? itemId;

  UpdateCartItemParams({this.quantity, this.itemId, this.sku});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['sku'] = sku;
    json['qty'] = quantity;
    json['itemId'] = itemId;
    return json;
  }
}
