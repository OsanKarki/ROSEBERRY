import 'package:ecommerce_app/features/auth/view/controller/auth_status_checker_controller.dart';
import 'package:ecommerce_app/features/bnb/view/bnb_controller.dart';
import 'package:ecommerce_app/features/shared/auth_middleware_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../core/widgets/error_view.dart';
import '../../cart/view/cart_page.dart';
import '../../cart/view/controller/get_to_cart_controller.dart';
import '../../category/view/category_page.dart';
import '../../home/view/home_page.dart';
import '../../profile/view/profile_page.dart';

class BottonNavigationBar extends StatefulWidget {
  const BottonNavigationBar({Key? key}) : super(key: key);

  @override
  State<BottonNavigationBar> createState() => _BottonNavigationBarState();
}

class _BottonNavigationBarState extends State<BottonNavigationBar> {
  final AuthStatusController _authStatusController =
      Get.put(AuthStatusController());
  final screens = [
    const HomePage(),
    const CategoryPage(),
    Obx(() => Get.find<AuthStatusController>().isAuthenticated.value
        ? const CartPage()
        : AuthMiddlewarePage()),
    Obx(() => Get.find<AuthStatusController>().isAuthenticated.value
        ? const ProfilePage()
        : const AuthMiddlewarePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BnbController>(
        init: BnbController(),
        builder: (controller) {
          return Scaffold(
            body: screens[Get.find<BnbController>().index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: Get.find<BnbController>().index,
              onTap: (newIndex) {
                Get.find<BnbController>().index = newIndex;
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_sharp),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Get.find<AuthStatusController>().isAuthenticated.value
                      ? Stack(
                          children: [
                            Icon(Icons.shopping_cart),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 7,
                                child: GetBuilder<GetCartController>(
                                  builder: (controller) {
                                    final result = controller.result;
                                    if (result != null) {
                                      return result
                                          .fold((l) => ErrorView(l.value),
                                              (cartDetails) {
                                        if (cartDetails.cartItemsModel !=
                                                null &&
                                            cartDetails
                                                .cartItemsModel!.isNotEmpty) {
                                          return Text(
                                            "${cartDetails.itemCount}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                          );
                                        } else {
                                          return SizedBox.shrink();
                                        }
                                      });
                                    } else {
                                      return Shimmer(
                                        child: Container(
                                          height: 100,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : Icon(Icons.shopping_cart),
                  label: 'cart',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Account'),
              ],
              fixedColor: const Color(0xff3F704D),
              type: BottomNavigationBarType.fixed,
            ),
          );
        });
  }
}
