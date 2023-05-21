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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ProductDetailsController>().getProductInfo(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text("${product.description}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "AVAILABILITY:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                " ${product.availability}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.green),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('SKU', style: TextStyle(fontSize: 16)),
                              Text(":${product.sku}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            const Text(
                              "Rs:",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
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
                );
              });
            } else {
              return Shimmer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Center(child: Container(height: 310,width: 350,color: Colors.grey.shade200,)),
                      SizedBox(height: 20,),
                      Container(height: 30,width: 350,color: Colors.grey.shade200,),
                      SizedBox(height: 20,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: 20,width: 200,color: Colors.grey.shade200,),
                          Container(height: 20,width: 120,color: Colors.grey.shade200,),
                        ],
                      ),
                      SizedBox(height: 20,),

                      Container(
                        height: 40,width: 140,
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
