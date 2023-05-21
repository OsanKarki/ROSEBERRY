import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/model/product_model.dart';
import 'package:get/get.dart';

import '../repository/product_repository.dart';

class ProductTopDealsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getProductInfo();
  }

  Either<NetworkException, List<ProductModel>>? result;

  Future<void> getProductInfo() async {
    result = await ProductRepository().getTopDealsProduct();

    update();
  }
}
