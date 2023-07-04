import 'address_model.dart';

class DefaultAddressModel {
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;

  DefaultAddressModel(
      { this.billingAddress,  this.shippingAddress});

  factory DefaultAddressModel.fromJson(Map<String, dynamic> json) {
    return DefaultAddressModel(
        billingAddress:json["billingAddress"]!=null? AddressModel.fromJson(json["billingAddress"]):null,
        shippingAddress: json["shippingAddress"]!= null?AddressModel.fromJson(json["shippingAddress"]):null);
  }
}
