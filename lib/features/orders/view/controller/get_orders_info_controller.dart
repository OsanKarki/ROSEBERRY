import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/addressbook/repository/address_repository.dart';
import 'package:ecommerce_app/features/orders/model/orders_info_model.dart';
import 'package:ecommerce_app/features/orders/repository/orders_repository.dart';
import 'package:get/get.dart';

class GetOrdersInfoController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getOrdersInfo();
  }

  Either<NetworkException, List<OrderInfoModel>>? result;

  Future<void> getOrdersInfo() async {
    result = await OrdersRepository().getOrderInfo();
    update();
  }
}
