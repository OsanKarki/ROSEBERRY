import 'package:ecommerce_app/features/addressbook/view/controller/get_default_address_controller.dart';
import 'package:get/get.dart';

class DefaultAddressBindings extends Bindings{
  @override
  void dependencies() {

   Get.put(GetDefaultAddressController());
  }

}