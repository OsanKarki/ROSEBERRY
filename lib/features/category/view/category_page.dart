import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/category/view/controller/category_controller.dart';
import 'package:ecommerce_app/features/category/view/widgets/category_content_view.dart';
import 'package:ecommerce_app/features/category/view/widgets/category_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../core/widgets/error_view.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kGreen600,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 340,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Search products',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                     const Icon(
                      Icons.notifications_none,
                      size: 25,
                       color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),

        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
            child: GetBuilder<CategoryController>(
              builder: (controller) {
                final result = controller.result;
                if (result != null) {
                  return result.fold((l) => ErrorView(l.value), (categoryList) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryScrollView(
                          categoryList: categoryList,
                          onCategoryTap: (i) {
                            setState(() {
                              index = i;
                            });
                          },
                        ),
                        CategoryContentView(
                            subCategoryModelList:
                                categoryList[index].subCategoryModel),
                      ],
                    );
                  });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ]));
  }
}
