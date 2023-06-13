class DelCartItemParams {
  final String? sku;
  final String? qty;
  final String? itemId;

  DelCartItemParams({this.sku, this.qty, this.itemId});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['sku'] = sku;
    json['qty'] = qty;
    json['item_id'] = itemId;
    return json;
  }
}
