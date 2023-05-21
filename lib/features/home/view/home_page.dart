import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_multiple_image_banner.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_best_seller.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_featured_category.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_image_slider.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_single_image_banner.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_top_deals.dart';
import 'package:ecommerce_app/features/home/view/widgets/home_top_rated_items.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kGreen600,
          title: const Center(
              child: Text(
            "RoseBerry",
            style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic),
          )),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),//scroll garda ko lagi
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const HomeImageSliders(),
                const HomeFeaturedCategory(),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: const Color(0xff168843),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top Rated',
                        style:TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {


                          },
                          child: const Text('View All >>',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.orangeAccent)))
                    ],
                  ),
                ),
                const HomeTopRatedItems(),
                const HomeMultipleImageBannerItems(),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: const Color(0xff168843),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Best Seller',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text('View All >>',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.orangeAccent)))
                    ],
                  ),
                ),
                const HomeBestSellerItems(),
                const HomeSingleImageBannerItems(),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
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
                            onPressed: () {},
                            child: const Text('View All >>',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.orangeAccent)))
                      ],
                    ),
                  ),
                ),
                const HomeTopDealsItems(),

              ],
            ),
          ),
        ));
  }
}
