import 'package:ecommerce_app/features/auth/view/controller/signin_controller.dart';
import 'package:get/get.dart';

class SignInBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
  }

}