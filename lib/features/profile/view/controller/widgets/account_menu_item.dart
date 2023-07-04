import 'package:flutter/material.dart';

import '../../../../../core/presentation/resources/app_colors.dart';

class AccountMenuItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function() onTap;

  const AccountMenuItem({
    super.key,
    this.icon,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 20,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.apply(color: kGreen600,),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 13,
            color: Colors.grey,
          )
        ],
      ),

    );
  }
}
