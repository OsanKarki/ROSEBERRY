import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/addressbook/model/address_model.dart';
import 'package:ecommerce_app/features/addressbook/repository/address_repository.dart';
import 'package:get/get.dart';

class GetNonDefaultAddressController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getAddressInfo();
  }

  Either<NetworkException, List<AddressModel>>? result;

  Future<void> getAddressInfo() async {
    result = await AddressRepository().getNonDefaultAddress();

    update();
  }
}