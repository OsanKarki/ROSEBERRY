import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/addressbook/model/default_address_model.dart';
import 'package:ecommerce_app/features/addressbook/repository/address_repository.dart';
import 'package:get/get.dart';

class GetDefaultAddressController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getDefaultAddressInfo();
  }

  Either<NetworkException, DefaultAddressModel>? result;

  Future<void> getDefaultAddressInfo() async {
    result = await AddressRepository().getDefaultAddresses();

    update();
  }
}
