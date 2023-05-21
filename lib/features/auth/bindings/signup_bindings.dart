import 'package:ecommerce_app/features/auth/view/controller/signup_controller.dart';
import 'package:get/get.dart';

class SignupBindings extends Bindings{
  @override
  void dependencies() {
   Get.put(SignupController());
  }

}