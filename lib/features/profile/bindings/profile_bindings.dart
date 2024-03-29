import 'package:ecommerce_app/features/profile/update_profile/update_profile_controller.dart';
import 'package:ecommerce_app/features/profile/view/controller/personal_info_controller.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.put((PersonalInfoController()));
    Get.put(ProfileUpdateController());
  }

}