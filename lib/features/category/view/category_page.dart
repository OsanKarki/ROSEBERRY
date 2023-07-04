import 'package:ecommerce_app/core/presentation/resources/app_colors.dart';
import 'package:ecommerce_app/features/bnb/view/controller/bnb_controller.dart';
import 'package:ecommerce_app/features/category/view/controller/category_controller.dart';
import 'package:ecommerce_app/features/category/view/widgets/category_content_view.dart';
import 'package:ecommerce_app/features/category/view/widgets/category_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/presentation/routes/routes.dart';
import '../../../core/widgets/error_view.dart';
import '../../cart/view/controller/get_to_cart_controller.dart';

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
            preferredSize: const Size.fromHeight(20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20,top:5 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.productSearchPage);
                      },
                      child: Container(
                        height: 45,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 20,

                              ),
                              const SizedBox(
                                width: 3,
                              ),
                               Text(
                                'Search products',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                     GestureDetector(
                       onTap: (){
                         Get.find<BnbController>().index = 2;
                       },
                       child: Stack(
                         children: [
                            Icon(
                            Icons.shopping_cart_outlined,
                            size: 25,
                             color: Colors.white,
                    ),
                           GetBuilder<GetCartController>(
                             builder: (controller) {
                               final result =
                                   controller.result;
                               if (result != null) {
                                 return result.fold(
                                         (l) =>
                                         SizedBox.shrink(),
                                         (cartDetails) {
                                       if (cartDetails
                                           .cartItemsModel !=
                                           null &&
                                           cartDetails
                                               .cartItemsModel!
                                               .isNotEmpty) {
                                         return Positioned(
                                             bottom: 0,
                                             right: 0,
                                             child: CircleAvatar(
                                                 backgroundColor:
                                                 Colors.red,
                                                 radius: 7,
                                                 child: Text(
                                                   "${cartDetails.itemCount}",
                                                   style: Theme.of(
                                                       context)
                                                       .textTheme
                                                       .bodySmall
                                                       ?.copyWith(
                                                     fontSize:
                                                     10,
                                                     color: Colors
                                                         .white,
                                                   ),
                                                 )));
                                       } else {
                                         return SizedBox
                                             .shrink();
                                       }
                                     });
                               } else {
                                 return SizedBox.shrink();
                               }
                             },
                           )
                         ],
                       ),
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
