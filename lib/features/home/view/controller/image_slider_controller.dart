import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../model/image_slider_model.dart';
import '../../repository/home_repository.dart';

class ImageSliderController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getImageInfo();
  }

  Either<NetworkException, List<ImageSliderModel>>? result;

  Future<void> getImageInfo() async {


    result = await HomeRepository().getImageSlider();

    update();
  }
}
