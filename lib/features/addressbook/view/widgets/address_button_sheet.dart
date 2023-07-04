import 'package:ecommerce_app/features/addressbook/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/presentation/resources/app_colors.dart';
import '../../../checkout/view/controller/checkout_controller.dart';
import '../controller/non_default_address_deletion_controller.dart';
import '../controller/set_defult_address_controller.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet(
      {super.key,
      required this.address,
      this.isDefault = false,
      required this.addressType});

  final AddressModel? address;
  final AddressType addressType;

  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!isDefault || (isDefault && addressType == AddressType.shipping))
            Row(
              children: [
                Icon(
                  Icons.home_filled,
                  color: kGreen600,
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                     Get.find<SetDefaultAddressController>().setDefaultBillingAddress(context, address);
                  },
                  child: Text("Set as default billing address"),
                )
              ],
            ),
          if (!isDefault || (isDefault && addressType == AddressType.billing))
          Row(
            children: [
              Icon(
                Icons.home_filled,
                color: kGreen600,
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                   Get.find<SetDefaultAddressController>().setDefaultShippingAddress(context, address);

                },
                child: Text("Set as default shipping address"),
              )
            ],
          ),
          if (!isDefault)
            Row(
              children: [
                Icon(
                  Icons.delete_outline_outlined,
                  color: kGreen600,
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Get.find<AddressDeletionController>()
                        .delAddress(context, "${address?.id}");
                  },
                  child: Text("Delete Address"),
                )
              ],
            ),
        ],
      ),
    );
  }
}

enum AddressType { shipping, billing, others }
