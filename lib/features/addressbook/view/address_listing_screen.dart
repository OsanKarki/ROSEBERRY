import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/get_default_address_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/controller/non_default_address_fetching_controller.dart';
import 'package:ecommerce_app/features/addressbook/view/widgets/address_button_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/error_view.dart';

class AddressListingPage extends StatelessWidget {
  const AddressListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addressAddingPage);
        },
        backgroundColor: kGreen600,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      appBar: AppBar(
        backgroundColor: kGreen600,
        title: Text("Address Book"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Default Shipping Address",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 5,
            ),
            DefaultShippingAddress(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Default Billing  Address",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 5,
            ),
            DefaultBillingAddress(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            NonDefaultAddresses(),
          ],
        ),
      ),
    );
  }
}

class NonDefaultAddresses extends StatelessWidget {
  const NonDefaultAddresses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<GetNonDefaultAddressController>(
        builder: (controller) {
          final result = controller.result;
          if (result != null) {
            return result.fold((l) => ErrorView(l.value),
                (addressList) {
              if (addressList.isEmpty) {
                return Center(
                    child: Column(
                  children: [
                    Image.asset(
                      "assets/png/noAddress.png",
                      width: 100,
                      color: Colors.orangeAccent,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Select Your address !!!",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.apply(color: kGreen600),
                    )
                  ],
                ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Non Default Address",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: addressList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              Get.back(result: addressList[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade400),
                                  borderRadius:
                                      BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(30),
                                                  color: kGreen400,
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .location_on_outlined,
                                                  color: Colors.white,
                                                  size: 20,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    "${addressList[index].firstName}"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "${addressList[index].lastName}"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext
                                                      context) {
                                                    return AddressBottomSheet(
                                                      address:
                                                          addressList[
                                                              index],
                                                      addressType:
                                                          AddressType
                                                              .others,
                                                      isDefault: false,
                                                    );
                                                  });
                                            },
                                            child: Icon(
                                              Icons.more_vert,
                                              size: 25,
                                              color: kGreen600,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            "${addressList[index].postalCode},"),
                                        Text(
                                            "${addressList[index].city}"),
                                        Text(
                                            "${addressList[index].country?.fullName}")
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${addressList[index].telephoneNo}"),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: CupertinoColors
                                                      .systemYellow)),
                                          height: 30,
                                          width: 60,
                                          child: Icon(
                                            Icons
                                                .edit_location_alt_outlined,
                                            color: CupertinoColors
                                                .systemYellow,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            });
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class DefaultBillingAddress extends StatelessWidget {
  const DefaultBillingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetDefaultAddressController>(builder: (controller) {
      return Builder(
        builder: (context) {
          final result = controller.result;
          if (result != null) {
            return result.fold((l) => ErrorView(l.value),
                (defaultBillingAddress) {
              final address = defaultBillingAddress;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap:(){
                    Get.back(result: address.billingAddress );

                  },
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
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30),
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
                                      Text(
                                          "${address.billingAddress?.firstName}"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          "${address.billingAddress?.lastName}"),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddressBottomSheet(
                                            address:
                                                address.billingAddress,
                                            addressType:
                                                AddressType.billing,
                                            isDefault: true,
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 25,
                                    color: kGreen600,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                  "${address.billingAddress?.postalCode},"),
                              Text("${address.billingAddress?.city}"),
                              Text(
                                  "${address.billingAddress?.country?.fullName}")
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${address.billingAddress?.telephoneNo}"),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CupertinoColors
                                            .systemYellow)),
                                height: 30,
                                width: 60,
                                child: Icon(
                                  Icons.edit_location_alt_outlined,
                                  color: CupertinoColors.systemYellow,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
              ;
            });
          } else {
            return SizedBox.shrink();
          }
        },
      );
    });
  }
}

class DefaultShippingAddress extends StatelessWidget {
  const DefaultShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetDefaultAddressController>(builder: (controller) {
      return Builder(
        builder: (context) {
          final result = controller.result;
          if (result != null) {
            return result.fold((l) => ErrorView(l.value),
                (defaultAddress) {
              final address = defaultAddress;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Get.back(result: address.shippingAddress);
                  },
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
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30),
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
                                      Text(
                                          "${address.shippingAddress?.firstName}"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          "${address.shippingAddress?.lastName}"),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddressBottomSheet(
                                            address:
                                                address.shippingAddress,
                                            isDefault: true,
                                            addressType:
                                                AddressType.shipping,
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 25,
                                    color: kGreen600,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                  "${address.shippingAddress?.postalCode},"),
                              Text("${address.shippingAddress?.city} ,"),
                              Text(
                                  "${address.shippingAddress?.country?.fullName} ,"),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${address.shippingAddress?.telephoneNo}"),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CupertinoColors
                                            .systemYellow)),
                                height: 30,
                                width: 60,
                                child: Icon(
                                  Icons.edit_location_alt_outlined,
                                  color: CupertinoColors.systemYellow,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
              ;
            });
          } else {
            return SizedBox.shrink();
          }
        },
      );
    });
  }
}
