import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/core/widgets/confirmation_dialog_box.dart';
import 'package:ecommerce_app/features/profile/view/controller/personal_info_controller.dart';
import 'package:flutter/cupertino.dart';
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
                  showDialog(context: context, builder: (context) => ConfirmationDialogBox(text: "Are you sure you want to logout", onPressed: (){
                    Get.find<AuthStatusController>()
                        .logout();
                    Get.back();

                  }),);
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
                            height: 220,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 31,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.apply(
                                            color: kGreen600,
                                          ),
                                    ),
                                    SizedBox(width: 5,),

                                    Text(
                                      "${personalInfo.lastname}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.apply(
                                            color: kGreen600,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("${personalInfo.email}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.apply(
                                          color: kGreen600,
                                        )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("${personalInfo.phoneNo}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.apply(
                                          color: kGreen600,
                                        )),
                                Align(
                                    widthFactor: 9,
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.updateProfileScreen,
                                          arguments: personalInfo,
                                        );
                                      },
                                      child: CircleAvatar(
                                          backgroundColor:
                                              CupertinoColors.systemYellow,
                                          child: Icon(
                                            Icons.edit,
                                            color: kGreen600,
                                          )),
                                    ))
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

                                    menuSpacing,
                                    AccountMenuItem(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.orderHistoryPage);
                                      },
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
                                    AccountMenuItem
                                      (
                                        onTap: () {},
                                        title: 'Help & FAQs',
                                        icon: Icons.help_center_outlined),
                                    menuSpacing,
                                    AccountMenuItem(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                            ConfirmationDialogBox(
                                              text: "Are you sure you want to logout",
                                              onPressed: () {
                                                Get.find<AuthStatusController>().logout();

                                              },
                                            ));

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
