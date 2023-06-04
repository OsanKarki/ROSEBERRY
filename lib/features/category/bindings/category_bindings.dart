import 'package:ecommerce_app/features/category/view/controller/category_controller.dart';
import 'package:get/get.dart';

class CategoryBindings extends Bindings{
  @override
  void dependencies() {
   Get.put(CategoryController());
  }

}