import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_multiple_image_banner.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_best_seller.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_featured_category.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_image_slider.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_single_image_banner.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_top_deals.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_top_rated_items.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kGreen600,
          title: const Center(
              child: Text(
            "RoseBerry",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          )),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), //scroll garda ko lagi
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: const [
                HomeImageSliders(),
                HomeFeaturedCategory(),
                HomeTopRatedItems(),
                HomeMultipleImageBannerItems(),
                HomeBestSellerItems(),
                HomeSingleImageBannerItems(),
                HomeTopDealsItems(),
              ],
            ),
          ),
        ));
  }
}
