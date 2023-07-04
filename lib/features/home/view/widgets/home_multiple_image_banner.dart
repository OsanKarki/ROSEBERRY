import 'package:ecommerce_app/features/home/view/controller/multiple_image_banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/widgets/error_view.dart';

class HomeMultipleImageBannerItems extends StatelessWidget {
  const HomeMultipleImageBannerItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultipleImageBannerController>(
      builder: (controller) {
        final result = controller.result;
        if (result != null) {
          return result.fold((l) => ErrorView(l.value), (productList) {
            return Container(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 170,
                          width: 360,
                          child: Image.network("${productList[index].image}",
                              fit: BoxFit.fill),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          });
        } else {
          return Shimmer(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
            child: Container(
              height: 170,
              width: 360,
              color: Colors.grey.shade200,
            ),
          ));
        }
      },
    );
  }
}
