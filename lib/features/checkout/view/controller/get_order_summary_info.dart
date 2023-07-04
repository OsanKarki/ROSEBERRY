import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/checkout/model/order_Summary_model.dart';
import 'package:ecommerce_app/features/checkout/repository/checkout_repository.dart';
import 'package:get/get.dart';

import '../../../addressbook/repository/address_repository.dart';

class GetOrderSummaryController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    // getOrderSummary();
  }

  Either<NetworkException, OrderSummaryModel>?result;
  Future<void>getOrderSummary()async{
    result = await CheckoutRepository().getOrderSummary();
    update();
  }
}