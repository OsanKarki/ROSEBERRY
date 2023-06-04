import 'package:ecommerce_app/features/product/controller/product_listing_controller.dart';
import 'package:get/get.dart';

class ProductListingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductListingController());

  }
}