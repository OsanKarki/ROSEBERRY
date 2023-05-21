import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/widgets/error_view.dart';
import '../controller/image_featured_category_controller.dart';

class HomeFeaturedCategory extends StatelessWidget {
  const HomeFeaturedCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageFeaturedCategoryController>(
      builder: (controller) {
        final result = controller.result;
        if (result != null) {
          return result.fold((l) => ErrorView(l.value),
                  (imageModelList) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "${imageModelList[index].image}"),
                              ),
                            ),
                            width: 80,
                            height: 80,
                          ),
                        );
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
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color:  Colors.grey.shade200,
                          shape: BoxShape.circle
                        ),
                        width: 80,
                        height: 80,

                      ),
                      Container(
                        decoration: BoxDecoration(
                            color:  Colors.grey.shade200,
                            shape: BoxShape.circle
                        ),
                        width: 80,
                        height: 80,

                      ),
                      Container(
                        decoration: BoxDecoration(
                            color:  Colors.grey.shade200,
                            shape: BoxShape.circle
                        ),
                        width: 80,
                        height: 80,

                      ),
                      Container(
                        decoration: BoxDecoration(
                            color:  Colors.grey.shade200,
                            shape: BoxShape.circle
                        ),
                        width: 80,
                        height: 80,

                      )
                    ],
                  ),
                ),
                );

        }
      },
    );
  }
}