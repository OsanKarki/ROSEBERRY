import 'package:ecommerce_app/features/auth/view/controller/auth_status_checker_controller.dart';
import 'package:ecommerce_app/features/shared/auth_middleware_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart/view/cart_page.dart';
import '../category/view/category_page.dart';
import '../home/view/home_page.dart';
import '../profile/view/profile_page.dart';

class BottonNavigationBar extends StatefulWidget {
  const BottonNavigationBar({Key? key}) : super(key: key);

  @override
  State<BottonNavigationBar> createState() => _BottonNavigationBarState();
}

class _BottonNavigationBarState extends State<BottonNavigationBar> {
  int index = 0;
  final screens = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    Obx(() =>Get.find<AuthStatusController>().isAuthenticated.value? const ProfilePage(): const AuthMiddlewarePage()),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_sharp),
            label: 'Category',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        fixedColor: const Color(0xff3F704D),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
