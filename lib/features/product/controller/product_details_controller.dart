import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/model/product_model.dart';
import 'package:get/get.dart';

import '../repository/product_repository.dart';

class ProductDetailsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  Either<NetworkException,ProductModel>? result;

  Future<void> getProductInfo(String sku) async {
    result = await ProductRepository().getProductDetails(sku: sku);

    update();
  }
}
