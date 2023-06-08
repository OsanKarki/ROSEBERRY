import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/core/widgets/primary_button.dart';
import 'package:ecommerce_app/features/bnb/view/bnb_controller.dart';
import 'package:ecommerce_app/features/cart/view/controller/get_to_cart_controller.dart';
import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../core/presentation/resources/app_colors.dart';
import '../../../core/widgets/error_view.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomSheet: GetBuilder<GetCartController>(
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
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text(
                                  "RS:",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  " ${double.parse("${cartDetails.grandTotal}")}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
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
                            onPressed: () {}),
                      )
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            });
          } else {
            return Shimmer(
                child: Container(
              height: 100,
            ));
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: kGreen600,
        title: Text(
          "My Cart",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
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
                              width: 100,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.productDetails,
                                      arguments: FilterQueryParams(
                                          sku:
                                              "${cartDetails.cartItemsModel?[index].sku}"));
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
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          height: 35,
                                          width: 35,
                                          color: Colors.grey.shade200,
                                          child: Center(
                                              child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.grey,
                                          ))),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Remove")
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
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      color: kGreen400,
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      color: Colors.white,
                                      child: Center(
                                          child: Text(double.tryParse(
                                                      "${cartDetails.cartItemsModel?[index].quantity}")
                                                  ?.toInt()
                                                  .toString() ??
                                              "")),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      color: kGreen400,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
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
                      Image.asset("assets/png/emtCart.png", height: 100),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Your Basket is Empty",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Choose products is that you want \nto buy and fill your cart",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      PrimaryButton(
                          text: "Start Shopping",
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
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
