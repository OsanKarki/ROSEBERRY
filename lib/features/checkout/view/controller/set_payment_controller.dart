import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/checkout/repository/checkout_repository.dart';
import 'package:ecommerce_app/features/checkout/view/controller/get_order_summary_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../addressbook/repository/address_repository.dart';

class SetPaymentController extends GetxController {
  Either<NetworkException, String>? result;

  Future<void> setPayment(BuildContext context, String payment) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    result = await CheckoutRepository().setPaymentMethod(payment);
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
      (r) {
        final snackBar = GetSnackBar(
          message: r,
          // Snackbar message
          backgroundColor: Colors.green,
          // Background color of the snackbar
          snackPosition: SnackPosition.BOTTOM,
          // Position of the snackbar
          duration: const Duration(seconds: 3),
          // Duration to display the snackbar
          isDismissible:
              true, // Whether the snackbar can be dismissed by the user
        );
        // Get.back();
        Get.showSnackbar(snackBar);
        Get.find<GetOrderSummaryController>().getOrderSummary();

      },
    );
  }
}
