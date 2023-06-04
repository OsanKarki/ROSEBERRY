import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/category/model/category_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../repository/category_repository.dart';

class CategoryController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getCategoryData();
  }

  Either<NetworkException, List<CategoryModel>>? result;

  Future<void> getCategoryData() async {
    result = await CategoryRepository().getCategory();
    update();
  }
}