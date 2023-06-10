import 'package:ecommerce_app/features/profile/update_profile/model/update_profile_model.dart';
import 'package:ecommerce_app/features/profile/update_profile/update_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/presentation/resources/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/primary_textfield.dart';
import '../../auth/model/signup_request_model.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePage();
}

class _UpdateProfilePage extends State<UpdateProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kGreen400, Colors.green.shade700],
                  begin: Alignment.topLeft,
                  tileMode: TileMode.mirror,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(125)),
              ),
              height: 300,
              width: double.infinity,
              child: const Text(
                'Update Information',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryTextField(
                          controller: firstNameController,
                          label: 'First Name',
                          prefixIcon: Icons.person,
                          borderRadius: 20,
                        ),
                        PrimaryTextField(
                          controller: lastNameController,
                          label: 'Last Name',
                          prefixIcon: Icons.person,
                          borderRadius: 20,
                        ),
                        PrimaryTextField(
                          controller: phoneNumberController,
                          prefixIcon: Icons.phone,
                          label: 'Phone Number',
                          borderRadius: 20,
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        PrimaryButton(
                          text: 'Update',
                          borderRadius: 20,
                          onPressed: () {
                            Get.find<ProfileUpdateController>().profileUpdate(
                                context,
                                ProfileUpdateParams(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    companyBrn: null));
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
