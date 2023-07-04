

import 'package:ecommerce_app/features/home/view/widgets/shimmer/primary_box_shimmer_effect.dart';
import 'package:ecommerce_app/features/product/controller/product_best_seller_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/presentation/routes/routes.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../product/model/filter_query_params.dart';
import '../../../product/view/widgets/product_card.dart';
class HomeBestSellerItems extends StatelessWidget {
  const HomeBestSellerItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          color: const Color(0xff168843),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                'Best Seller',
                   style:  Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.white,)
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.productListingPage,arguments:FilterQueryParams(bestSeller: true));

                  },
                  child:  Text('View All >>',
                      style: Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.yellow,),))
            ],
          ),
        ),
        GetBuilder<ProductBestSellerController>(
          builder: (controller) {
            final result = controller.result;
            if (result != null) {
              return result.fold((l) => ErrorView(l.value),
                      (productList) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
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
