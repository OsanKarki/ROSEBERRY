import 'package:ecommerce_app/features/auth/view/controller/auth_status_checker_controller.dart';
import 'package:ecommerce_app/features/bnb/view/bnb_controller.dart';
import 'package:ecommerce_app/features/shared/auth_middleware_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/view/cart_page.dart';
import '../../category/view/category_page.dart';
import '../../home/view/home_page.dart';
import '../../profile/view/profile_page.dart';

class BottonNavigationBar extends StatefulWidget {
  const BottonNavigationBar({Key? key}) : super(key: key);

  @override
  State<BottonNavigationBar> createState() => _BottonNavigationBarState();
}

class _BottonNavigationBarState extends State<BottonNavigationBar> {
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
        builder: (context) {
          return Scaffold(
            body: screens[Get.find<BnbController>().index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: Get.find<BnbController>().index,
              onTap: (newIndex) {
                Get.find<BnbController>().index = newIndex;
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_sharp),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'cart',),
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
