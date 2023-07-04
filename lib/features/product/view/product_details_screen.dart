import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/core/widgets/primary_button.dart';
import 'package:ecommerce_app/features/bnb/view/controller/bnb_controller.dart';
import 'package:ecommerce_app/features/cart/view/controller/add_cart_controller.dart';
import 'package:ecommerce_app/features/product/controller/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../core/widgets/error_view.dart';
import '../../auth/view/controller/auth_status_checker_controller.dart';
import '../../cart/model/add_to_cart_params.dart';
import '../../cart/view/controller/get_to_cart_controller.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final AuthStatusController _authStatusController =
      Get.put(AuthStatusController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ProductDetailsController>().getProductInfo(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GetBuilder<ProductDetailsController>(builder: (controller) {
            return Builder(
              builder: (context) {
                final result = controller.result;
                if (result != null) {
                  return result.fold((l) => ErrorView(l.value), (productList) {
                    final product = productList;
                    return SizedBox(
                      height: double.maxFinite,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 45),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(
                                            Icons.arrow_back_ios_new,
                                            color: kGreen600,
                                          ),
                                          backgroundColor: Colors.grey.shade400,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.until((route) =>
                                              route.settings.name ==
                                              AppRoutes.bottomNavigationBar);
                                          Get.find<BnbController>().index = 2;
                                        },
                                        child: CircleAvatar(
                                          child: Stack(
                                            children: [
                                              Icon(
                                                Icons.shopping_cart_outlined,
                                                color: kGreen600,
                                              ),
                                              GetBuilder<GetCartController>(
                                                builder: (controller) {
                                                  final result =
                                                      controller.result;
                                                  if (result != null) {
                                                    return result.fold(
                                                        (l) =>
                                                            SizedBox.shrink(),
                                                        (cartDetails) {
                                                      if (cartDetails
                                                                  .cartItemsModel !=
                                                              null &&
                                                          cartDetails
                                                              .cartItemsModel!
                                                              .isNotEmpty) {
                                                        return Positioned(
                                                            bottom: 0,
                                                            right: 0,
                                                            child: CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                radius: 7,
                                                                child: Text(
                                                                  "${cartDetails.itemCount}",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodySmall
                                                                      ?.copyWith(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                )));
                                                      } else {
                                                        return SizedBox
                                                            .shrink();
                                                      }
                                                    });
                                                  } else {
                                                    return Shimmer(
                                                        child: Container(
                                                      height: 100,
                                                    ));
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                          backgroundColor: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Center(
                                    child: Image.network(
                                      "${product.image}",
                                      fit: BoxFit.cover,
                                      height: 300,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Text("${product.description}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("AVAILABILITY:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        Text(" ${product.availability}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: product.availability ==
                                                          "IN STOCK"
                                                      ? Colors.blue
                                                      : Colors.redAccent,
                                                )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('SKU',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        Text(":${product.sku}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: kGreen600
                                                )),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Row(
                                    children: [
                                       Text(
                                        "Rs:",
                                        style:  Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                      ),
                                      Text(
                                        "${double.parse("${product.price}")}",
                                        style:  Theme.of(context)
                                            .textTheme
                                            .titleLarge?.copyWith(color: Colors.orange)
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: PrimaryButton(
                              height: 18,
                              text: 'Add to Cart',
                              onPressed: () {
                                if (product.availability == "IN STOCK") {
                                  bool isAuthenticated = _authStatusController
                                      .isAuthenticated.value;
                                  if (isAuthenticated) {
                                    Get.find<CartController>().cartAdd(
                                        context,
                                        AddToCartParams(
                                          sku: product.sku,
                                          quantity: product.quantity,
                                        ));
                                  } else {
                                    Get.toNamed(AppRoutes.loginPage);
                                  }
                                  ;
                                }
                              },
                              borderRadius: 5,
                              buttonColor: product.availability == "IN STOCK"
                                  ? kGreen400
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    );
                  });
                } else {
                  return Shimmer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Container(
                            height: 310,
                            width: 350,
                            color: Colors.grey.shade200,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            width: 350,
                            color: Colors.grey.shade200,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 20,
                                width: 200,
                                color: Colors.grey.shade200,
                              ),
                              Container(
                                height: 20,
                                width: 120,
                                color: Colors.grey.shade200,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            width: 140,
                            color: Colors.grey.shade200,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }),
        ));
  }
}
