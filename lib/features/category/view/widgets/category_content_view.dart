import 'package:ecommerce_app/core/presentation/routes/routes.dart';
import 'package:ecommerce_app/features/category/model/category_model.dart';
import 'package:ecommerce_app/features/product/model/filter_query_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryContentView extends StatelessWidget {
  const CategoryContentView({
    this.subCategoryModelList,
    super.key,
  });

  final List<SubCategoryModel>? subCategoryModelList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(subCategoryModelList?.length ?? 0, (index) {
              final subCategoryModel = subCategoryModelList![index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Theme(
                      data: ThemeData(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.productListingPage,
                                  arguments: FilterQueryParams(categoryId: subCategoryModel.id));
                            },
                            child: Text("${subCategoryModel.name}")),
                        children: List.generate(
                          subCategoryModelList?[index]
                                  .subCategoryChildModel
                                  ?.length ??
                              0,
                          (childIndex) {
                            final childCategoryModel =
                                subCategoryModelList?[index]
                                    .subCategoryChildModel?[childIndex];
                            return ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.productListingPage,
                                      arguments: childCategoryModel?.id);
                                },
                                child: Text("${childCategoryModel?.name}"),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
