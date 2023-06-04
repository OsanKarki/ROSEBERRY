

import 'package:ecommerce_app/features/home/view/widgets/shimmer/primary_box_shimmer_effect.dart';
import 'package:ecommerce_app/features/product/controller/product_top_deals_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/presentation/routes/routes.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../product/controller/product_top_rated_controller.dart';
import '../../../product/model/filter_query_params.dart';
import '../../../product/view/widgets/product_card.dart';
class HomeTopDealsItems extends StatelessWidget {
  const HomeTopDealsItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            color: const Color(0xff168843),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Deals',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.productListingPage,arguments:FilterQueryParams(topDeals: true));

                    },
                    child: const Text('View All >>',
                        style: TextStyle(
                            fontSize: 15, color: Colors.orangeAccent)))
              ],
            ),
          ),
        ),
        GetBuilder<ProductTopDealsController>(
          builder: (controller) {
            final result = controller.result;
            if (result != null) {
              return result.fold((l) => ErrorView(l.value),
                      (productList) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(

                        height: 155,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = productList[index];
                            return ProductCard(product: product);
                          },
                        ),
                      ),
                    );
                  });
            } else {

              return Shimmer(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      PrimaryBoxShimmerEffect(),
                      PrimaryBoxShimmerEffect(),
                      PrimaryBoxShimmerEffect(),

                    ],
                  ),
                ),
              );

            }
          },
        ),
      ],
    );
  }
}
