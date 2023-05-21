import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/widgets/error_view.dart';
import '../controller/image_slider_controller.dart';

class HomeImageSliders extends StatelessWidget {
  const HomeImageSliders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageSliderController>(
      builder: (controller) {
        final result = controller.result;
        if (result != null) {
          return result.fold((l) => ErrorView(l.value), (imageModelList) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: imageModelList.map((imageModel) {
                  return ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: Image.network(
                          "${imageModel.image}",
                          fit: BoxFit.cover,
                        ),
                      ));
                }).toList(),
              ),
            );
          });
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer(
              enabled: true,
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
