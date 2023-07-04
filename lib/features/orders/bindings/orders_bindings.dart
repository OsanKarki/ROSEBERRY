import 'package:ecommerce_app/features/orders/view/controller/get_orders_info_controller.dart';
import 'package:get/get.dart';

class OrderBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(GetOrdersInfoController());
  }

}