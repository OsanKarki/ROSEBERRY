import 'package:ecommerce_app/features/product/controller/product_best_seller_controller.dart';
import 'package:ecommerce_app/features/product/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/product/controller/product_top_deals_controller.dart';
import 'package:ecommerce_app/features/product/controller/product_top_rated_controller.dart';
import 'package:get/get.dart';

class ProductBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductTopRatedController());
    Get.put(ProductTopDealsController());
    Get.put(ProductBestSellerController());

  }
}
