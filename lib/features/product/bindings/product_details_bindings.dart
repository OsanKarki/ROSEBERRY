import 'package:ecommerce_app/features/product/controller/product_details_controller.dart';
import 'package:get/get.dart';

class ProductDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductDetailsController());

  }
}
