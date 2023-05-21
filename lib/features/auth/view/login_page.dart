import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/auth/model/signin_request_model.dart';
import 'package:ecommerce_app/features/auth/view/controller/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/primary_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                'Login',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryTextField(
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              return null; //no mistake -> all good
                            } else {
                              return "This field is required";
                            }
                          },
                          controller: emailController,
                          label: 'Email',
                          prefixIcon: Icons.mail,
                          borderRadius: 20,
                        ),
                        PrimaryTextField(
                          validator: (value) {
                            //validator use chai this feild is required vanera dekhauna lai
                            if (value != null && value.isNotEmpty) {
                              return null; //no mistake -> all good
                            } else {
                              return "This field is required";
                            }
                          },
                          controller: passwordController,
                          prefixIcon: Icons.vpn_key,
                          label: 'Password',
                          isPassword: true,
                          borderRadius: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                  color: Color(0xff564C4A),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        PrimaryButton(
                          text: 'Login',
                          borderRadius: 20,
                          onPressed: () {
                            if (formKey.currentState?.validate() == true) {
                              Get.find<SignInController>().signInRegister(
                                  context,
                                  SignInRequestModel(
                                      email: emailController.text,
                                      password: passwordController.text));
                            }
                          },
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.signupPage);
                                },
                                child: const Text(
                                  'Signup',
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
