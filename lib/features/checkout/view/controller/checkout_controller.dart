import 'package:ecommerce_app/features/addressbook/model/address_model.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  AddressModel? _selectedShippingAddress;
  AddressModel? _selectedBillingAddress;

  AddressModel? get selectedShippingAddress {
    return _selectedShippingAddress;
  }

  AddressModel? get selectedBillingAddress {
    return _selectedBillingAddress;
  }

  set selectedShippingAddress(AddressModel? addressModel) {
    _selectedShippingAddress = addressModel;
    update();
  }

  set selectedBillingAddress(AddressModel? addressModel){
    _selectedBillingAddress = addressModel;
    update();

  }
}
