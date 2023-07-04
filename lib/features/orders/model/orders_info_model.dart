class OrderInfoModel {
  final String? orderId;
  final String? status;
  final String? total;
  final String? createdAt;
  final String? shippingName;
  final String? referenceId;

  OrderInfoModel({
    this.orderId,
    this.status,
    this.total,
    this.createdAt,
    this.shippingName,
    this.referenceId,
  });

  factory OrderInfoModel.fromJson(Map<String, dynamic> json) {
    return OrderInfoModel(
        orderId: json["order_id"],
        status: json["status"],
        total: json["grand_total"],
        shippingName: json["shipping_name"],
        referenceId: json["order_incremental_id"],
    createdAt: json["created_at"]);
  }
}
