import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double? height;

  const AppLogo({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/png/mainLogo.png",
      width: height,
    );
  }
}
