import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/presentation/resources/app_colors.dart';
import '../../model/category_model.dart';

class CategoryScrollView extends StatefulWidget {
  const CategoryScrollView(
      {super.key, required this.categoryList, required this.onCategoryTap});

  final List<CategoryModel> categoryList;
  final Function(int) onCategoryTap;

  @override
  State<CategoryScrollView> createState() => _CategoryScrollViewState();
}

class _CategoryScrollViewState extends State<CategoryScrollView> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Expanded(


      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final category = widget.categoryList[index];
          final isSelected = selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              widget.onCategoryTap(index);
              selectedCategoryIndex = index;
            },
            child: Container(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
              height: 100,
              color: isSelected ? Colors.white : Colors.grey.shade300,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: kGreen400,
                    child: Text(
                      category.name![0],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${category.name}",
                    textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
