import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/signup_request_model.dart';
import '../../repository/auth_repository.dart';

class SignupController extends GetxController {
  Either<NetworkException, String>? result;

  Future<void> signupRegister(
      BuildContext context, SignupRequestModel signupRequestModel) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    result = await AuthRepository().register(signupRequestModel);
    Get.back();
    result?.fold(
      (l) {
     final snackBar=   GetSnackBar(
          message: l.value, // Snackbar message
          backgroundColor: Colors.red, // Background color of the snackbar
          snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
          duration: const Duration(seconds: 3), // Duration to display the snackbar
          isDismissible: true, // Whether the snackbar can be dismissed by the user

        );
         Get.showSnackbar(snackBar);
      },
      (r) {
        final snackBar=   GetSnackBar(
          message: r, // Snackbar message
          backgroundColor: Colors.green, // Background color of the snackbar
          snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
          duration: const Duration(seconds: 3), // Duration to display the snackbar
          isDismissible: true, // Whether the snackbar can be dismissed by the user

        );
        Get.back();
        Get.showSnackbar(snackBar);
      },
    );
  }
}
