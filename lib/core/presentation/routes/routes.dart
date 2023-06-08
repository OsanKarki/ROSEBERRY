import 'package:ecommerce_app/features/auth/bindings/auth_status_bindings.dart';
import 'package:ecommerce_app/features/auth/bindings/signin_bindings.dart';
import 'package:ecommerce_app/features/auth/bindings/signup_bindings.dart';
import 'package:ecommerce_app/features/auth/view/login_page.dart';
import 'package:ecommerce_app/features/auth/view/signup_page.dart';
import 'package:ecommerce_app/features/bnb/bottom_navigation_bar.dart';
import 'package:ecommerce_app/features/cart/bindings/card_bindings.dart';
import 'package:ecommerce_app/features/category/bindings/category_bindings.dart';
import 'package:ecommerce_app/features/home/bindings/home_bindings.dart';
import 'package:ecommerce_app/features/product/bindings/product_bindings.dart';
import 'package:ecommerce_app/features/product/bindings/product_details_bindings.dart';
import 'package:ecommerce_app/features/product/bindings/product_listing_bindings.dart';
import 'package:ecommerce_app/features/product/view/product_details_screen.dart';
import 'package:ecommerce_app/features/product/view/product_listing_page.dart';
import 'package:ecommerce_app/features/profile/bindings/profile_bindings.dart';
import 'package:ecommerce_app/features/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import '../../../features/cart/view/cart_page.dart';
import '../../../features/category/view/category_page.dart';
import '../../../features/home/view/home_page.dart';
import '../../../features/shared/auth_middleware_page.dart';

class AppRoutes {
  static String homePage = "/homePage";

  static String categoryPage = "/homePage";
  static String cartPage = "/cartPage";
  static String profilePage = "/homePage";
  static String bottomNavigationBar = "/bottomNavigationBar";
  static String productDetails = "/productDetails";
  static String loginPage = "/loginPage";
  static String signupPage = "/signupPage";
  static String productListingPage = "/productListingPage";
  static String splashScreen = "/splashScreen";

  static final routes = [
    GetPage(
      name: homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: categoryPage,
      page: () => const CategoryPage(),
    ),
    GetPage(
      name: cartPage,
      page: () => const CartPage(),


    ),
    GetPage(
      name: profilePage,
      page: () => const AuthMiddlewarePage(),
    ),
    GetPage(
        name: bottomNavigationBar,
        page: () => const BottonNavigationBar(),
        bindings: [
          HomeBindings(),
          ProductBindings(),
          AuthStatusBindings(),
          ProfileBindings(),
          CategoryBindings(),
          CartBindings(),

        ]),
    GetPage(
      name: productDetails,
      page: () => const ProductDetails(),
      binding: ProductDetailsBindings(),
    ),
    GetPage(
        name: loginPage,
        page: () => const LoginPage(),
        binding: SignInBindings()),
    GetPage(
        name: signupPage,
        page: () => const SignupPage(),
        binding: SignupBindings()),
    GetPage(
        name: productListingPage,
        page: () =>  const ProductListingPage(),
        binding: ProductListingBindings()),
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    )
  ];
}
