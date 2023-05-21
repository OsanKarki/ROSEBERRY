import 'package:ecommerce_app/features/auth/view/controller/auth_status_checker_controller.dart';
import 'package:get/get.dart';

class AuthStatusBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthStatusController(),permanent: true);
  }
}
