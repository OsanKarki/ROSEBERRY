import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/model/del_cart_item_params.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'get_to_cart_controller.dart';


class DelCartItemController extends GetxController {
  Either<NetworkException, String>? result;

  Future<void> cartDel(
      BuildContext context,  int id) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    result = await CartRepository().delCartItem(id);
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
        Get.find<GetCartController>().getCartInfo();
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
        Get.back();
        Get.showSnackbar(snackBar);
      },
    );
  }
}
