import 'package:ecommerce_app/features/auth/view/controller/auth_status_checker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: () {
          Get.find<AuthStatusController>().logout();
          }, icon: Icon(Icons.logout))],
          title: Text('Cart'),
        ),
        body: Column(
          children: [
            Obx(
              () => Get.find<AuthStatusController>().isAuthenticated.value
                  ? Text('Loggedin')
                  : Text('NotLoggedIn'),
            )
          ],
        ));
  }
}
