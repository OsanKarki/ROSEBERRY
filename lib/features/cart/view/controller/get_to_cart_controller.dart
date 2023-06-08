import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/cart/model/get_to_cart_model.dart';
import 'package:ecommerce_app/features/cart/repository/cart_repository.dart';
import 'package:get/get.dart';

class GetCartController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCartInfo();
  }

  Either<NetworkException, CartDetailsModel>? result;

  Future<void> getCartInfo() async {
    result = await CartRepository().getCartItem();
    update();
  }
}
