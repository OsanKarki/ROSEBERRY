import 'package:ecommerce_app/features/cart/view/controller/get_to_cart_controller.dart';
import 'package:get/get.dart';

import '../view/controller/add_cart_controller.dart';

class CartBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CartController());
    Get.put(GetCartController());
  }
}
