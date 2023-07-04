import '../../../core/data/remote/constants.dart';

class OrderSummaryModel {
  final String? itemCount;
  final String? itemQuantity;
  final String? grandTotal;
  final String? subTotal;
  final String? shippingDescription;
  final String? paymentMethod;
  final String? shippingAmount;
  final List<SubOrderSummaryModel>? items;

  OrderSummaryModel(
      {this.itemCount,
      this.itemQuantity,
      this.grandTotal,
      this.subTotal,
      this.shippingDescription,
      this.paymentMethod,
      this.items,
      this.shippingAmount});

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) {
    return OrderSummaryModel(
        grandTotal: json["grand_total"],
        itemCount: json["items_count"],
        shippingAmount: json["shipping_amount"],
        itemQuantity: json["items_qty"],
        paymentMethod: json["payment_method"],
        shippingDescription: json["shipping_description"],
        subTotal: json["subtotal"],
        items: json["items"]
            .map<SubOrderSummaryModel>(
                (dataJson) => SubOrderSummaryModel.fromJson(dataJson))
            .toList());
  }
}

class SubOrderSummaryModel {
  final String? itemId;
  final String? sku;
  final String? name;
  final String? qty;
  final String? price;
  final String? image;

  SubOrderSummaryModel(
      {this.itemId, this.sku, this.name, this.qty, this.price, this.image});

  factory SubOrderSummaryModel.fromJson(Map<String, dynamic> json) {
    final imageUrl = json['image']['image'];
    final prefix = json['image']['thumbnail'];
    final completeImageUrl = "$baseUrl/media/catalog/product/$imageUrl";
    return SubOrderSummaryModel(
        itemId: json["item_id"],
        sku: json["sku"],
        qty: json["qty"],
        name: json["name"],
        price: json["price"],
        image: completeImageUrl);
  }
}
