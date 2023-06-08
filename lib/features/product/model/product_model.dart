import 'package:ecommerce_app/core/data/remote/constants.dart';

class ProductModel {
  final String? id;
  final String? name;
  final String? description;
  final String? quantity;
  final String? price;
  final String? rating;
  final String? availability;
  final String? image;
  final String? sku;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.quantity,
      this.price,
      this.rating,
      this.availability,
      this.image,
      this.sku});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final imageUrl = json['product_images']['image'];
    final prefix = json['product_images']['prefix'];
    final completeImageUrl = "$baseUrl/$prefix/$imageUrl";
    return ProductModel(
        id: json['entity_id'],
        name: json['name'],
        description: json['meta_description'],
        quantity: json['quantity_and_stock_status'],
        price: json['price'],
        rating: json['ratings'],
        availability: json['availability'],
        image: completeImageUrl,
        sku: json['sku']);
  }
}
