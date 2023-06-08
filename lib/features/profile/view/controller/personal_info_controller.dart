import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/profile/model/profile_personal_info_model.dart';
import 'package:ecommerce_app/features/profile/repository/profile_repository.dart';
import 'package:get/get.dart';

class PersonalInfoController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getPersonalInfo();
  }

  Either<NetworkException, ProfilePersonalInfoModel>? result;

  Future<void> getPersonalInfo() async {
    result = await ProfileRepository().getUserInfo();

    update();
  }
}
