import 'package:ecommerce_app/features/checkout/view/controller/checkout_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/get_order_summary_info.dart';
import 'package:ecommerce_app/features/checkout/view/controller/get_payment_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/initiate_transaction_ontroller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/place_order_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/set_payment_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/shipping_controller.dart';
import 'package:get/get.dart';

class CheckoutBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(CheckoutController());
    Get.put(ShippingController());
    Get.put(PaymentController());
    Get.put(SetPaymentController());

    Get.put(PlaceOrderController());
    Get.put(InitiateTransactionController());

  }

}