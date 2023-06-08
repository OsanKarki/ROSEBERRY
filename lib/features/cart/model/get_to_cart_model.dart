import '../../../core/data/remote/constants.dart';

class CartDetailsModel {
  final String? itemCount;
  final String? grandTotal;
  final String? subTotal;
  final String? subTotalDiscounted;
  final List<CartItemModel>? cartItemsModel;

  CartDetailsModel(
      {this.itemCount,
      this.grandTotal,
      this.subTotal,
      this.subTotalDiscounted,
      this.cartItemsModel});

  factory CartDetailsModel.fromJson(Map<String, dynamic> json) {
    return CartDetailsModel(
        itemCount: json['items_count'],
        grandTotal: json['grand_total'],
        subTotal: json['subtotal'],
        subTotalDiscounted: json['subtotal_with_discount'],
        cartItemsModel: json['items']
            .map<CartItemModel>((dataJson) => CartItemModel.fromJson(dataJson))
            .toList());
  }
}

class CartItemModel {
  final String? sku;
  final String? name;
  final String? quantity;
  final String? price;
  final String? image;

  CartItemModel({
    this.sku,
    this.name,
    this.quantity,
    this.price,
    this.image,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final image1Url = json['image']['image'];
    final image2Url = json['image']['thumbnail'];

    final image3Url = json['image']['small_image'];
    final completeImageUrl = "$baseUrl/media/catalog/product$image1Url";

    return CartItemModel(
        sku: json['sku'],
        name: json['name'],
        quantity: json['qty'],
        price: json['price'],
        image: completeImageUrl);
  }
}
