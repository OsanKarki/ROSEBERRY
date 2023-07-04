import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/view/controller/add_cart_controller.dart';
import 'package:ecommerce_app/features/checkout/model/order_response.dart';
import 'package:ecommerce_app/features/checkout/repository/checkout_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../addressbook/repository/address_repository.dart';
import '../../../cart/view/controller/get_to_cart_controller.dart';
import '../../model/transaction_params.dart';
import 'initiate_transaction_ontroller.dart';

class PlaceOrderController extends GetxController {
  Future<void> placeOrder(BuildContext context) async {
    Either<NetworkException, OrderData>? result;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    result = await CheckoutRepository().placeOrder();
    update();
    Get.back();
    result?.fold(
      (l) {
        final snackBar = GetSnackBar(
          message: l.value,
          // Snackbar message
          backgroundColor: Colors.red,
          // Background color of the snackbar
          snackPosition: SnackPosition.BOTTOM,
          // Position of the snackbar
          duration: const Duration(seconds: 3),
          // Duration to display the snackbar
          isDismissible:
              true, // Whether the snackbar can be dismissed by the user
        );
        Get.showSnackbar(snackBar);
      },
      (r) async {
        Get.find<InitiateTransactionController>().initiateTransaction(
          context,
          TransactionParams(
            email: r.email,
            reference: r.reference,
            amount: r.amount,
          ),
        );
        Get.find<GetCartController>().getCartInfo();
      },
    );
  }
}
