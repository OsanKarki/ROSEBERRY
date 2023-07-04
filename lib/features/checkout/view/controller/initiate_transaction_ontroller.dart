import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/checkout/model/transaction_params.dart';
import 'package:ecommerce_app/features/checkout/repository/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../addressbook/repository/address_repository.dart';
import '../../model/initiate_transaction_model.dart';

class InitiateTransactionController extends GetxController {
  Either<NetworkException, InitiateTransactionModel>? result;

  Future<void> initiateTransaction(
      BuildContext context, TransactionParams transactionParams) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    result =
        await TransactionRepository().initializeTransaction(transactionParams);
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
            (r)  {
          Get.toNamed(AppRoutes.payStackPaymentPage,arguments: r);


    },

    );
  }
}
