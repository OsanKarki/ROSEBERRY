import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/profile/view/controller/personal_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/error_view.dart';
import '../../auth/view/controller/auth_status_checker_controller.dart';
import 'controller/widgets/account_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Account',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.find<AuthStatusController>().logout();
                },
                icon: Icon(Icons.logout))
          ],
          backgroundColor: kGreen600,
        ),
        body: GetBuilder<PersonalInfoController>(
          builder: (controller) {
            final result = controller.result;
            if (result != null) {
              return result.fold((l) => ErrorView(l.value), (personalInfo) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            color: Colors.grey,
                            width: 380,
                            height: 210,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.yellow.shade700,
                                      child: Text(
                                        "${personalInfo.firstName?[0]}",
                                        style: const TextStyle(
                                            fontSize: 35,
                                            color: kGreen600,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${personalInfo.firstName}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: kGreen600),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${personalInfo.lastname}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: kGreen600),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${personalInfo.email}",
                                  style: const TextStyle(
                                      fontSize: 17, color: kGreen600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${personalInfo.phoneNo}",
                                  style: const TextStyle(
                                      fontSize: 17, color: kGreen600),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: SingleChildScrollView(
                              child: Builder(builder: (context) {
                                const menuSpacing = SizedBox(
                                  height: 40,
                                );
                                return Column(
                                  children: [
                                    AccountMenuItem(
                                      onTap: () {},
                                      icon: Icons.book_outlined,
                                      title: 'Address book',
                                    ),
                                    menuSpacing,
                                    AccountMenuItem(
                                      onTap: () {},
                                      title: 'Order History',
                                      icon: Icons.access_time,
                                    ),
                                    menuSpacing,
                                    AccountMenuItem(
                                        onTap: () {},
                                        title: 'Terms and Condition',
                                        icon: Icons.sticky_note_2_outlined),
                                    menuSpacing,
                                    AccountMenuItem(
                                      onTap: () {},
                                      title: 'Privacy and Cookie Policy',
                                      icon: Icons.note,
                                    ),
                                    menuSpacing,
                                    AccountMenuItem(
                                        onTap: () {},
                                        title: 'About Us',
                                        icon: Icons.info_outline),
                                    menuSpacing,
                                    AccountMenuItem(
                                      onTap: () {},
                                      title: 'Contact Us',
                                      icon: Icons.phone_outlined,
                                    ),
                                    menuSpacing,
                                    AccountMenuItem(
                                        onTap: () {},
                                        title: 'Help & FAQs',
                                        icon: Icons.help_center_outlined),
                                    menuSpacing,
                                    AccountMenuItem(
                                      onTap: () {
                                        Get.find<AuthStatusController>()
                                            .logout();
                                      },
                                      title: 'Logout',
                                      icon: Icons.logout,
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
