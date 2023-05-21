import 'package:flutter/material.dart';

class AccountMenuItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function() onTap;


 const  AccountMenuItem({super.key,
    this.icon ,
   required this.onTap,
   required this.title,


  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(

            children:  [
              Icon(icon,

                color: Colors.grey,
                size: 30,
              ),
              SizedBox(width: 10,),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          Icon(Icons.arrow_forward_ios,size: 17,color: Colors.grey,)
        ],
      ),
    );
  }
}
