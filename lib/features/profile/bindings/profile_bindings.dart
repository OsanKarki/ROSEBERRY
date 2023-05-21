import 'package:ecommerce_app/features/product/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/profile/view/controller/personal_info_controller.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.put((PersonalInfoController()));
  }

}