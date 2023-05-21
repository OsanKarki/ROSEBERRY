import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kGreen600,
        elevation: 0,
        title: const Text('Category'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_none,
              size: 25,
            ),
          )
        ],
      ),
      body: Container(
        height: 75,
        width: double.infinity,
        color: kGreen600,
        child: Stack(children: [
          Center(
            child: Container(
              height: 50,
              width: 370,

              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.search,color: Colors.grey.shade700,),
                    const SizedBox(width: 5,),
                    const Text('Search products',style: TextStyle(color: Colors.grey),)
                  ],

                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
