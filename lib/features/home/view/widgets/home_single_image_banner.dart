import 'package:ecommerce_app/features/home/view/controller/multiple_image_banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/widgets/error_view.dart';
import '../controller/single_image_banner_controller.dart';

class HomeSingleImageBannerItems extends StatelessWidget {
  const HomeSingleImageBannerItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleImageBannerController>(
      builder: (controller) {
        final result = controller.result;
        if (result != null) {
          return result.fold((l) => ErrorView(l.value), (productList) {
            final product = productList;
            return SizedBox(
              height: 80,
              child: Image.network("${product .image}", fit: BoxFit.fill),
            );
          });
        } else {
          return Shimmer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 15),
                child: Container(
                  height: 90,
                  width: 360,
                  color: Colors.grey.shade200,
                ),
              ));
        }
      },
    );
  }
}
