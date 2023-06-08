import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/auth/model/signin_request_model.dart';
import 'package:ecommerce_app/features/auth/view/controller/auth_status_checker_controller.dart';
import 'package:ecommerce_app/features/profile/view/controller/personal_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../repository/auth_repository.dart';

class SignInController extends GetxController {
  Either<NetworkException, String>? result;

  Future<void> signInRegister(
      BuildContext context, SignInRequestModel signInRequestModel) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    result = await AuthRepository().login(signInRequestModel);
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
            Get.find<PersonalInfoController>().getPersonalInfo();
            Get.find<AuthStatusController>().updateAuthenticationStatus(true);
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
