import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/core/widgets/primary_button.dart';
import 'package:ecommerce_app/features/bnb/view/controller/bnb_controller.dart';
import 'package:ecommerce_app/features/cart/view/controller/del_all_cart_item_controller.dart';
import 'package:ecommerce_app/features/cart/view/controller/del_cart_item_controller.dart';
import 'package:ecommerce_app/features/cart/view/controller/get_to_cart_controller.dart';
import 'package:ecommerce_app/features/cart/view/controller/update_cart_item_controller.dart';
import 'package:ecommerce_app/features/cart/view/widgets/cart_bottom_Sheet.dart';
import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/presentation/resources/app_colors.dart';
import '../../../core/widgets/confirmation_dialog_box.dart';
import '../../../core/widgets/error_view.dart';
import '../model/del_cart_item_params.dart';
import '../model/update_cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<GetCartController>().getCartInfo();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomSheet: CartBottomSheet(),
      appBar: AppBar(
        backgroundColor: kGreen600,
        title: Text(
          "My Cart",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          GetBuilder<GetCartController>(
            builder: (controller) {
              final result = controller.result;
              if (result != null) {
                return result.fold((l) => SizedBox.shrink(), (cartDetails) {
                  if (cartDetails.cartItemsModel != null &&
                      cartDetails.cartItemsModel!.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmationDialogBox(
                                text:
                                    "Are you sure you want to remove all \n item from cart?",
                                onPressed: () {
                                  Get.find<DelAllCartItemController>()
                                      .cartAllDel(context, DelCartItemParams());
                                  Get.back();
                                },
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete_outline_outlined,
                          size: 25,
                        ),
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
          ),
        ],
      ),
      body: GetBuilder<GetCartController>(
        builder: (controller) {
          final result = controller.result;
          if (result != null) {
            return result.fold((l) => ErrorView(l.value), (cartDetails) {
              if (cartDetails.cartItemsModel != null &&
                  cartDetails.cartItemsModel!.isNotEmpty) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: cartDetails.cartItemsModel?.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, index) {
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: 70,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.productDetails,
                                      arguments:

                                              "${cartDetails.cartItemsModel?[index].sku}");
                                },
                                child: Image.network(
                                  "${cartDetails.cartItemsModel?[index].image}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${cartDetails.cartItemsModel?[index].name}",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          int itemId = int.parse(
                                              "${cartDetails.cartItemsModel?[index].itemId}");
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ConfirmationDialogBox(
                                                text:
                                                    "Are you sure you want to remove this \n item from cart?",
                                                onPressed: () {
                                                  Get.find<
                                                          DelCartItemController>()
                                                      .cartDel(context, itemId);
                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          color: Colors.grey.shade200,
                                          child: Center(
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Remove",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.apply(
                                                color: Colors.black54,
                                              ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "Rs: ${double.parse("${cartDetails.cartItemsModel?[index].price}")}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.apply(
                                          color: Colors.red,
                                        )),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if ((cartDetails.cartItemsModel?[index]
                                                    .quantity ??
                                                0) >
                                            1) {
                                          Get.find<UpdateCartItemController>()
                                              .cartUpdate(
                                                  context,
                                                  UpdateCartItemParams(
                                                    sku: cartDetails
                                                        .cartItemsModel?[index]
                                                        .sku,
                                                    itemId: cartDetails
                                                        .cartItemsModel?[index]
                                                        .itemId,
                                                    quantity: (cartDetails
                                                                .cartItemsModel?[
                                                                    index]
                                                                .quantity ??
                                                            0) -
                                                        1,
                                                  ));
                                        }
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        color: kGreen400,
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      color: Colors.white,
                                      child: Center(
                                          child: Text(double.tryParse(
                                                      "${cartDetails.cartItemsModel?[index].quantity}")
                                                  ?.toInt()
                                                  .toString() ??
                                              "")),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.find<UpdateCartItemController>()
                                            .cartUpdate(
                                                context,
                                                UpdateCartItemParams(
                                                  sku: cartDetails
                                                      .cartItemsModel?[index]
                                                      .sku,
                                                  itemId: cartDetails
                                                      .cartItemsModel?[index]
                                                      .itemId,
                                                  quantity: (cartDetails
                                                              .cartItemsModel?[
                                                                  index]
                                                              .quantity ??
                                                          0) +
                                                      1,
                                                ));
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        color: kGreen400,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/png/emtCart.png", height: 80),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Your Basket is Empty",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Choose products is that you want \nto buy and fill your cart",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      PrimaryButton(
                          text: "Start Shopping",
                          height: 10,
                          width: 200,
                          borderRadius: 5,
                          buttonColor: kGreen400,
                          onPressed: () {
                            Get.find<BnbController>().index = 0;
                          })
                    ],
                  ),
                );
              }
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
