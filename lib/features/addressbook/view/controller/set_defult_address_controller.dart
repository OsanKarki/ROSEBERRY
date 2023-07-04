import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/addressbook/model/address_model.dart';
import 'package:ecommerce_app/features/addressbook/repository/address_repository.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/get_default_address_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/non_default_address_fetching_controller.dart';
import 'package:ecommerce_app/features/checkout/view/controller/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDefaultAddressController extends GetxController {

  Future<void> setDefaultShippingAddress(BuildContext context, AddressModel? addressModel) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    Either<NetworkException, String>? result = await AddressRepository().setDefaultShippingAddress("${addressModel?.id}");
    Get.back();
    result.fold(
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
        Get.find<GetDefaultAddressController>().getDefaultAddressInfo();
        Get.find<GetNonDefaultAddressController>().getAddressInfo();
        Get.find<CheckoutController>().selectedShippingAddress= addressModel;

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
  Future<void> setDefaultBillingAddress(BuildContext context, AddressModel? addressModel) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    Either<NetworkException, String>? result = await AddressRepository().setDefaultBillingAddress("${addressModel?.id}");
    Get.back();
    result.fold(
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
        Get.find<GetDefaultAddressController>().getDefaultAddressInfo();
        Get.find<GetNonDefaultAddressController>().getAddressInfo();
        Get.find<CheckoutController>().selectedBillingAddress= addressModel;

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
