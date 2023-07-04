class ShippingParams{
  final String? shippingMethod;
  final int? shippingAddressId;
  final int? billingAddressId;

  ShippingParams({
    this.shippingMethod,
    this.shippingAddressId,
    this.billingAddressId
});
  Map<String,dynamic>toJson(){
    final json = <String,dynamic>{};
    json["shipping_method"]=shippingMethod;
    json["shipping_address_id"]=shippingAddressId;
    json["billing_address_id"]=billingAddressId;
    return json;
  }
}