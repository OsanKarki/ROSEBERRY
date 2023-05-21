import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/home/model/image_featured_category_model.dart';
import 'package:ecommerce_app/features/home/repository/home_featured_category_repository.dart';
import 'package:get/get.dart';

class ImageFeaturedCategoryController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getImageInfo();
  }

  Either<NetworkException, List<ImageFeaturedCategoryModel>>? result;

  Future<void> getImageInfo() async {
    result = await HomeFeaturedCategoryRepository().getBannerImage();
    update();
  }
}
