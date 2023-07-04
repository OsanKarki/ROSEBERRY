import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/checkout/view/controller/checkout_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/get_order_summary_info.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({
    super.key,
  });

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Shipping Methods"),
          SizedBox(
            height: 10,
          ),
          ShippingMethods(
            text: "Free Shipping",
          ),
          SizedBox(
            height: 30,
          ),
          Text("Select shipping address"),
          SizedBox(
            height: 10,
          ),
          ShippingAddress(),
          SizedBox(
            height: 30,
          ),
          Text("Select billing address"),
          SizedBox(
            height: 10,
          ),
          BillingAddress(),
        ]),
      ),
    );
  }
}

class ShippingMethods extends StatelessWidget {
  final String? text;

  const ShippingMethods({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: kGreen600),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: kGreen600,
            size: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text(text ?? ""),
        ],
      ),
    );
  }
}

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (checkoutController) {
      final address = checkoutController.selectedShippingAddress;

      return address != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: kGreen400,
                                  ),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                children: [
                                  Text("${address.firstName}"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("${address.lastName}"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("${address.postalCode},"),
                          Text("${address.city}"),
                          Text("${address.country?.fullName}")
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${address.telephoneNo}"),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.addressListingPage);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CupertinoColors.systemYellow)),
                              height: 30,
                              width: 60,
                              child: Icon(
                                Icons.forward,
                                color: CupertinoColors.systemYellow,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : GestureDetector(
              onTap: () async {
                final result = await Get.toNamed(AppRoutes.addressListingPage);
                checkoutController.selectedShippingAddress = result;
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemYellow)),
                height: 50,
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: CupertinoColors.systemYellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "select shipping address !!",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.orangeAccent),
                    )
                  ],
                ),
              ),
            );
    });
  }
}

class BillingAddress extends StatelessWidget {
  const BillingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (checkoutController) {
      final address = checkoutController.selectedBillingAddress;

      return address != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: kGreen400,
                                  ),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                children: [
                                  Text("${address.firstName}"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("${address.lastName}"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("${address.postalCode},"),
                          Text("${address.city}"),
                          Text("${address.country?.fullName}")
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${address.telephoneNo}"),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.addressListingPage);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CupertinoColors.systemYellow)),
                              height: 30,
                              width: 60,
                              child: Icon(
                                Icons.forward,
                                color: CupertinoColors.systemYellow,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : GestureDetector(
              onTap: () async {
                final result = await Get.toNamed(AppRoutes.addressListingPage);
                checkoutController.selectedBillingAddress = result;
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemYellow)),
                height: 50,
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: CupertinoColors.systemYellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "select billing address ! !",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.orangeAccent),
                    )
                  ],
                ),
              ),
            );
    });
  }
}
