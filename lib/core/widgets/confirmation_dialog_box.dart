import 'package:ecommerce_app/core/widgets/primary_button.dart';
import 'package:ecommerce_app/core/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../presentation/resources/app_colors.dart';

class ConfirmationDialogBox extends StatelessWidget {
  final String text;
     final VoidCallback onPressed;
  const ConfirmationDialogBox({

    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        height: 150,
        width: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(
                10)),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,
          children: [
            Text(text,

              textAlign:
              TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
            Row(
              children: [
                Expanded(
                  child:
                  SecondaryButton(
                      text: "No",
                      onPressed:
                          () {
                        Get.back();
                          },
                      borderColor: kGreen600,
                      textColor: kGreen600),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child:
                  PrimaryButton(
                      text: "yes",
                      onPressed:
                          onPressed,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
