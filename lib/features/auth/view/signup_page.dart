import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/auth/model/signup_request_model.dart';
import 'package:ecommerce_app/features/auth/view/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/presentation/resources/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/primary_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  late  GlobalKey<FormState> formKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey= GlobalKey<FormState>();
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
                'Signup',
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
                          validator: (value) {
                            if(value!=null && value.isNotEmpty){
                              return null;//no mistake -> all good

                            }else {
                              return "This field is required";
                            }
                          },
                          controller: firstNameController,
                          label: 'First Name',
                          prefixIcon: Icons.person,
                          borderRadius: 20,
                        ),
                        PrimaryTextField(
                          validator: (value) {
                            if(value!=null && value.isNotEmpty){
                              return null;//no mistake -> all good

                            }else {
                              return "This field is required";
                            }
                          },
                          controller: lastNameController,
                          label: 'Last Name',
                          prefixIcon: Icons.person,
                          borderRadius: 20,
                        ),
                        PrimaryTextField(
                          validator: (value) {
                            if(value!=null && value.isNotEmpty){
                              return null;//no mistake -> all good

                            }else {
                              return "This field is required";
                            }
                          },
                          controller: emailController,
                          prefixIcon: Icons.mail,
                          label: 'Email',
                          borderRadius: 20,
                        ),
                        PrimaryTextField(
                          validator: (value) {
                            if(value!=null && value.isNotEmpty){
                              return null;//no mistake -> all good

                            }else {
                              return "This field is required";
                            }
                          },
                          controller: passwordController,
                          prefixIcon: Icons.vpn_key,
                          label: 'Password',
                          isPassword: true,
                          borderRadius: 20,
                        ),
                        PrimaryTextField(
                          validator: (value) {
                            if(value!=null && value.isNotEmpty){
                              if(value!=passwordController.text){
                                return "Password and confirm password must be same";
                              }
                              return null;//no mistake -> all good

                            }else {
                              return "This field is required";
                            }
                          },

                          prefixIcon: Icons.vpn_key,
                          label: 'Confirm Password',
                          isPassword: true,
                          borderRadius: 20,
                        ),
                        PrimaryTextField(
                          validator: (value) {
                            if(value!=null && value.isNotEmpty){
                              return null;//no mistake -> all good

                            }else {
                              return "This field is required";
                            }
                          },
                          controller: phoneNumberController,
                          prefixIcon: Icons.phone,
                          label: 'Phone Number',
                          borderRadius: 20,
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        PrimaryButton(
                          text: 'CREATE AN ACCOUNT',
                          borderRadius: 20,
                          onPressed: () {
                           if(formKey.currentState?.validate()==true){
                             Get.find<SignupController>()
                                 .signupRegister(context,SignupRequestModel(
                                 firstName: firstNameController.text,
                                 lastName: lastNameController.text,
                                 email: emailController.text,
                                 password: passwordController.text,
                                 phoneNumber: phoneNumberController.text

                             ));
                           }

                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already a member?"),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.loginPage);
                                },
                                child: const Text(
                                  'SignIn',
                                  style: TextStyle(color: kGreen400),
                                ))
                          ],
                        )
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
