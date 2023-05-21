import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/home/model/multiple_image_banner_model.dart';
import 'package:ecommerce_app/features/home/repository/home_multiple_image_banner_repository.dart';
import 'package:get/get.dart';

class MultipleImageBannerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getImageInfo();
  }

  Either<NetworkException, List<MultipleImageBannerModel>>? result;

  Future<void> getImageInfo() async {
    result = await HomeMultipleImageBannerRepository().getMultipleBannerImage();
    update();
  }
}
