import 'package:ecommerce_app/features/home/view/controller/multiple_image_banner_controller.dart';
import 'package:get/get.dart';

import '../view/controller/image_featured_category_controller.dart';
import '../view/controller/image_slider_controller.dart';
import '../view/controller/single_image_banner_controller.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ImageSliderController());
    Get.put(ImageFeaturedCategoryController());
    Get.put(MultipleImageBannerController());
    Get.put(SingleImageBannerController());


  }

}