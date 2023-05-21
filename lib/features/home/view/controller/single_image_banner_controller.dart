import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/home/repository/home_single_image_banner_repository.dart';
import 'package:get/get.dart';

import '../../model/single_image_banner_model.dart';

class SingleImageBannerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getImageInfo();
  }

  Either<NetworkException, SingleImageBannerModel>? result;

  Future<void> getImageInfo() async {
    result = await HomeSingleImageBannerRepository().getSingleBannerImage();
    update();
  }
}
