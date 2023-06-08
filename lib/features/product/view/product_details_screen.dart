import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/core/widgets/primary_button.dart';
import 'package:ecommerce_app/features/cart/view/controller/add_cart_controller.dart';
import 'package:ecommerce_app/features/product/controller/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../core/widgets/error_view.dart';
import '../../auth/view/controller/auth_status_checker_controller.dart';
import '../../cart/model/add_to_cart_params.dart';

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
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Center(
                                    child: Image.network(
                                      "${product.image}",
                                      fit: BoxFit.cover,
                                      width: 300,
                                      height: 300,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Text("${product.description}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "AVAILABILITY:",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          " ${product.availability}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: product.availability ==
                                                      "IN STOCK"
                                                  ? Colors.blue
                                                  : Colors.redAccent,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('SKU',
                                            style: TextStyle(fontSize: 16)),
                                        Text(":${product.sku}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green)),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Rs:",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "${double.parse("${product.price}")}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: PrimaryButton(
                              height: 20,
                              text: 'Add to bag',
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
                              width: 200,
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
