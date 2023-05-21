import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final double height;
  final double? width;
  final double? borderRadius;
  final Color? buttonColor;
  final Color? textColor;

  static const double defaultBorderRadius = 9;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.height = 15,
    this.width,
    this.buttonColor = kGreen400,
    this.textColor,
    this.borderRadius = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: height),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? defaultBorderRadius),
          ),
        ),
        child: Center(
            child:
                Text(text!, style: TextStyle(color: textColor, fontSize: 18))),
      ),
    );
  }
}
