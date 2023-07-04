import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/checkout/model/payment_model.dart';
import 'package:ecommerce_app/features/checkout/repository/checkout_repository.dart';
import 'package:get/get.dart';

import '../../../addressbook/repository/address_repository.dart';

class PaymentController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPaymentMethod();
  }

  Either<NetworkException, PaymentModel>? result;

  Future<void> getPaymentMethod() async {
    result = await CheckoutRepository().getPaymentMethod();


    update();
  }
}
