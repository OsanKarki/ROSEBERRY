import 'package:ecommerce_app/features/addressbook/view/controller/get_default_address_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/non_default_address_deletion_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/non_default_address_fetching_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/country_listing_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/country_province_listing_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/set_defult_address_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/non_default_address_adding_controller.dart';
import 'package:get/get.dart';

class AddressBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AddNonDefaultAddressController());
    Get.put(CountryListingController());
    Get.put(ProvinceListingController());
    Get.put(GetNonDefaultAddressController());
    Get.put(AddressDeletionController());
    Get.put(SetDefaultAddressController());

    Get.put(GetDefaultAddressController());
  }

}