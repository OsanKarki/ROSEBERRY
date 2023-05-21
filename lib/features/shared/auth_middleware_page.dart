import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/core/widgets/primary_button.dart';
import 'package:ecommerce_app/core/widgets/secondary_button.dart';
import 'package:ecommerce_app/features/shared/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddlewarePage extends StatelessWidget {
  const AuthMiddlewarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreen600,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(),
            const SizedBox(height: 20,),
            PrimaryButton(
              onPressed: () {
                Get.toNamed(AppRoutes.loginPage);
              },
              text: 'Login',
              borderRadius: 5,
              buttonColor: Colors.white,
              textColor: kGreen400,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'New Here ?',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(
              height: 25,
            ),
            SecondaryButton(text: 'Create Account',
                onPressed: () {
              Get.toNamed(AppRoutes.signupPage);
                },
                borderRadius: 5),

          ],
        ),
      ),
    );
  }
}
