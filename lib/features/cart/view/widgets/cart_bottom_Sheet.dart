import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/presentation/resources/app_colors.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controller/get_to_cart_controller.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetCartController>(
      builder: (controller) {
        final result = controller.result;
        if (result != null) {
          return result.fold((l) => ErrorView(l.value), (cartDetails) {
            if (cartDetails.cartItemsModel != null &&
                cartDetails.cartItemsModel!.isNotEmpty) {
              return Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total(${cartDetails.itemCount} items) :",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.apply(
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text("RS:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.apply(
                                      color: Colors.black,
                                      fontSizeDelta: 2.5,
                                      fontWeightDelta: 1)),
                              Text(
                                  " ${double.parse("${cartDetails.grandTotal}")}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.apply(
                                      color: Colors.red,
                                      fontSizeDelta: 2.5,
                                      fontWeightDelta: 1)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PrimaryButton(
                          text: "PROCEED TO SHIPPING",
                          borderRadius: 5,
                          buttonColor: kGreen400,
                          onPressed: () {
                            Get.toNamed(AppRoutes.checkoutPage);
                          }),
                    )
                  ],
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          });
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}