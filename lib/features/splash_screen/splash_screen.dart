import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/shared/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2)).then((value){
      Get.offAllNamed(AppRoutes.bottomNavigationBar);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreen600,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AppLogo(),
          SpinKitFadingCube(
            color: Colors.white,
            size: 50.0,
          )
        ],
      ),
    );
  }
}
