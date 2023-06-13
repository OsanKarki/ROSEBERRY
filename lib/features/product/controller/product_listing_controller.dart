import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:ecommerce_app/features/product/model/product_model.dart';
import 'package:get/get.dart';

import '../repository/product_repository.dart';

class ProductListingController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Either<NetworkException, List<ProductModel>>? result;

  Future<void> getProductInfo(FilterQueryParams filterQueryParams) async {
    result = await ProductRepository()
        .getProductList(filterQueryParams: filterQueryParams);

    update();
  }
}
