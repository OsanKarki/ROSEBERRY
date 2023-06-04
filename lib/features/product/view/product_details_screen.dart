import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/widgets/primary_button.dart';
import 'package:ecommerce_app/features/product/controller/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../core/widgets/error_view.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 0;

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
          child: Column(children: [
            GetBuilder<ProductDetailsController>(
              builder: (controller) {
                final result = controller.result;
                if (result != null) {
                  return result.fold((l) => ErrorView(l.value), (productList) {
                    final product = productList;
                    return Padding(
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
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Text("${product.description}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        color:
                                            product.availability == "IN STOCK"
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
                                          fontSize: 16, color: Colors.green)),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
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
                          Divider(
                            thickness: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Quantity',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 65,
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Decrease quantity logic
                                          setState(() {
                                            if (quantity > 0) {
                                              quantity--;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 40,
                                          color: kGreen400,
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        border: Border.all(
                                          color: kGreen400,
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          quantity.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Increase quantity logic
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 40,
                                        color: kGreen400,
                                        child: Icon(
                                          Icons.add,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            height: 20,
                          ),

                          Align(
                            heightFactor: 4,
                              alignment: Alignment.bottomRight,
                              child: PrimaryButton(text: 'Add to bag', onPressed: () {},width: 200,borderRadius: 5,buttonColor: kGreen400,))
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
                          Divider(
                            thickness: 2,
                            color: Colors.grey.shade200,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 70,
                                  color: Colors.grey.shade200,
                                ),
                                SizedBox(
                                  width: 65,
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 30,
                                        width: 40,
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 40,
                                      color: Colors.grey.shade200,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 40,
                                      color: Colors.grey.shade200,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            height: 20,
                            color: Colors.grey.shade200,
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            )
          ]),
        ));
  }
}
